library hyper_polyline;

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

/// The options allowing tappable polyline tweaks
class CwPolyLineLayer extends PolylineLayer {
  /// The list of [TaggedPolyline] which could be tapped
  @override
  // ignore: overridden_fields
  final List<TaggedPolyline> polylines;

  /// The tolerated distance between pointer and user tap to trigger the [onTap] callback
  final double pointerDistanceTolerance;

  /// The callback to call when a polyline was hit by the tap
  final void Function(List<TaggedPolyline>, TapUpDetails tapPosition)? onTap;

  /// The optional callback to call when no polyline was hit by the tap
  final void Function(TapUpDetails tapPosition)? onMiss;

  /// The optional callback to call when no polyline was double hit by the tap
  final void Function(TapDownDetails tapPosition)? onDoubleMiss;

  CwPolyLineLayer(
      {super.key,
      this.polylines = const [],
      this.onTap,
      this.onMiss,
      this.onDoubleMiss,
      this.pointerDistanceTolerance = 15,
      super.polylineCulling = false});

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;
    return TappablePolylineLayer(
        this, mapState, mapState.mapController.mapEventStream);
  }
}

/// A polyline with a tag
class TaggedPolyline extends Polyline {
  /// The name of the polyline
  final String? tag;

  TaggedPolyline(
      {required points,
      strokeWidth = 1.0,
      color = const Color(0xFF00FF00),
      borderStrokeWidth = 0.0,
      borderColor = const Color(0xFFFFFF00),
      gradientColors,
      colorsStop,
      isDotted = false,
      this.tag})
      : super(
            points: points,
            strokeWidth: strokeWidth,
            color: color,
            borderStrokeWidth: borderStrokeWidth,
            borderColor: borderColor,
            gradientColors: gradientColors,
            colorsStop: colorsStop,
            isDotted: isDotted);
}

class TappablePolylineLayer extends StatelessWidget {
  /// The options allowing tappable polyline tweaks
  final CwPolyLineLayer polylineOpts;

  /// The flutter_map [MapState]
  final FlutterMapState map;

  /// The Stream used by flutter_map to notify us when a redraw is required
  final Stream<void> stream;

  const TappablePolylineLayer(this.polylineOpts, this.map, this.stream,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints bc) {
        final size = Size(bc.maxWidth, bc.maxHeight);
        return _build(context, size, polylineOpts.onTap, polylineOpts.onMiss,
            polylineOpts.onDoubleMiss);
      },
    );
  }

  Widget _build(BuildContext context, Size size, Function? onTap,
      Function? onMiss, Function? onDoubleMiss) {
    return StreamBuilder<void>(
      stream: stream, // a Stream<void> or null
      builder: (BuildContext context, _) {
        for (var polylineOpt in polylineOpts.polylines) {
          polylineOpt.offsets.clear();

          if (polylineOpts.polylineCulling &&
              !polylineOpt.boundingBox.isOverlapping(map.bounds)) {
            // Skip this polyline as it is not within the current map bounds (i.e not visible on screen)
            continue;
          }

          var i = 0;
          for (var point in polylineOpt.points) {
            var pos = map.project(point);
            pos = pos.multiplyBy(map.getZoomScale(map.zoom, map.zoom)) -
                map.pixelOrigin;
            polylineOpt.offsets.add(Offset(pos.x.toDouble(), pos.y.toDouble()));
            if (i > 0 && i < polylineOpt.points.length) {
              polylineOpt.offsets
                  .add(Offset(pos.x.toDouble(), pos.y.toDouble()));
            }
            i++;
          }
        }

        return GestureDetector(
            onDoubleTap: () {
              // For some strange reason i have to add this callback for the onDoubleTapDown callback to be called.
            },
            onDoubleTapDown: (TapDownDetails details) {
              // Zoom map when double tap down
              // _zoomMap(details, context);
              _handlePolylineDoubleTap(details, onDoubleMiss);
            },
            onTapUp: (TapUpDetails details) {
              _forwardCallToMapOptions(details, context);
              _handlePolylineTap(details, onTap, onMiss);
            },
            child: Stack(
              children: [
                for (final polylineOpt in polylineOpts.polylines)
                  CustomPaint(
                    painter: PolylinePainter(polylineOpt, false, map),
                    size: size,
                  ),
              ],
            ));
      },
    );
  }

  void _handlePolylineDoubleTap(
      TapDownDetails details, Function? onDoubleMiss) {
    // We might hit close to multiple polylines. We will therefore keep a reference to these in this map.
    Map<double, List<TaggedPolyline>> candidates = {};

    // Calculating taps in between points on the polyline. We
    // iterate over all the segments in the polyline to find any
    // matches with the tapped point within the
    // pointerDistanceTolerance.
    for (Polyline currentPolyline in polylineOpts.polylines) {
      for (var j = 0; j < currentPolyline.offsets.length - 1; j++) {
        // We consider the points point1, point2 and tap points in a triangle
        var point1 = currentPolyline.offsets[j];
        var point2 = currentPolyline.offsets[j + 1];
        var tap = details.localPosition;

        // To determine if we have tapped in between two po ints, we
        // calculate the length from the tapped point to the line
        // created by point1, point2. If this distance is shorter
        // than the specified threshold, we have detected a tap
        // between two points.
        //
        // We start by calculating the length of all the sides using pythagoras.
        var a = _distance(point1, point2);
        var b = _distance(point1, tap);
        var c = _distance(point2, tap);

        // To find the height when we only know the lengths of the sides, we can use Herons formula to get the Area.
        var semiPerimeter = (a + b + c) / 2.0;
        var triangleArea = sqrt(semiPerimeter *
            (semiPerimeter - a) *
            (semiPerimeter - b) *
            (semiPerimeter - c));

        // We can then finally calculate the length from the tapped point onto the line created by point1, point2.
        // Area of triangles is half the area of a rectangle
        // area = 1/2 base * height -> height = (2 * area) / base
        var height = (2 * triangleArea) / a;

        // We're not there yet - We need to satisfy the edge case
        // where the perpendicular line from the tapped point onto
        // the line created by point1, point2 (called point D) is
        // outside of the segment point1, point2. We need
        // to check if the length from D to the original segment
        // (point1, point2) is less than the threshold.

        var hypotenus = max(b, c);
        var newTriangleBase = sqrt((hypotenus * hypotenus) - (height * height));
        var lengthDToOriginalSegment = newTriangleBase - a;

        if (height < polylineOpts.pointerDistanceTolerance &&
            lengthDToOriginalSegment < polylineOpts.pointerDistanceTolerance) {
          var minimum = min(height, lengthDToOriginalSegment);

          candidates[minimum] ??= <TaggedPolyline>[];
          candidates[minimum]!.add(currentPolyline as TaggedPolyline);
        }
      }
    }

    if (candidates.isEmpty) {
      if (onDoubleMiss is Function) {
        onDoubleMiss(details);
      }
    }
  }

  void _handlePolylineTap(
      TapUpDetails details, Function? onTap, Function? onMiss) {
    // We might hit close to multiple polylines. We will therefore keep a reference to these in this map.
    Map<double, List<TaggedPolyline>> candidates = {};

    // Calculating taps in between points on the polyline. We
    // iterate over all the segments in the polyline to find any
    // matches with the tapped point within the
    // pointerDistanceTolerance.
    for (Polyline currentPolyline in polylineOpts.polylines) {
      for (var j = 0; j < currentPolyline.offsets.length - 1; j++) {
        // We consider the points point1, point2 and tap points in a triangle
        var point1 = currentPolyline.offsets[j];
        var point2 = currentPolyline.offsets[j + 1];
        var tap = details.localPosition;

        // To determine if we have tapped in between two po ints, we
        // calculate the length from the tapped point to the line
        // created by point1, point2. If this distance is shorter
        // than the specified threshold, we have detected a tap
        // between two points.
        //
        // We start by calculating the length of all the sides using pythagoras.
        var a = _distance(point1, point2);
        var b = _distance(point1, tap);
        var c = _distance(point2, tap);

        // To find the height when we only know the lengths of the sides, we can use Herons formula to get the Area.
        var semiPerimeter = (a + b + c) / 2.0;
        var triangleArea = sqrt(semiPerimeter *
            (semiPerimeter - a) *
            (semiPerimeter - b) *
            (semiPerimeter - c));

        // We can then finally calculate the length from the tapped point onto the line created by point1, point2.
        // Area of triangles is half the area of a rectangle
        // area = 1/2 base * height -> height = (2 * area) / base
        var height = (2 * triangleArea) / a;

        // We're not there yet - We need to satisfy the edge case
        // where the perpendicular line from the tapped point onto
        // the line created by point1, point2 (called point D) is
        // outside of the segment point1, point2. We need
        // to check if the length from D to the original segment
        // (point1, point2) is less than the threshold.

        var hypotenus = max(b, c);
        var newTriangleBase = sqrt((hypotenus * hypotenus) - (height * height));
        var lengthDToOriginalSegment = newTriangleBase - a;

        if (height < polylineOpts.pointerDistanceTolerance &&
            lengthDToOriginalSegment < polylineOpts.pointerDistanceTolerance) {
          var minimum = min(height, lengthDToOriginalSegment);

          candidates[minimum] ??= <TaggedPolyline>[];
          candidates[minimum]!.add(currentPolyline as TaggedPolyline);
        }
      }
    }

    if (candidates.isNotEmpty) {
      // We look up in the map of distances to the tap, and choose the shortest one.
      var closestToTapKey = candidates.keys.reduce(min);
      onTap!(candidates[closestToTapKey], details);
    } else {
      if (onMiss is Function) {
        onMiss(details);
      }
    }
  }

  void _forwardCallToMapOptions(TapUpDetails details, BuildContext context) {
    final latlng = _offsetToLatLng(
        details.localPosition, context.size!.width, context.size!.height);

    final tapPosition =
        TapPosition(details.globalPosition, details.localPosition);

    // Forward the onTap call to map.options so that we won't break onTap
    if (map.options.onTap != null) {
      map.options.onTap!(tapPosition, latlng);
    }
  }

  // Todo: Remove this method is v2
  @Deprecated('Distance method should no longer be part of public API')
  double distance(Offset point1, Offset point2) {
    return _distance(point1, point2);
  }

  double _distance(Offset point1, Offset point2) {
    var distancex = (point1.dx - point2.dx).abs();
    var distancey = (point1.dy - point2.dy).abs();

    var distance = sqrt((distancex * distancex) + (distancey * distancey));

    return distance;
  }

  LatLng _offsetToLatLng(Offset offset, double width, double height) {
    var localPoint = CustomPoint(offset.dx, offset.dy);
    var localPointCenterDistance =
        CustomPoint((width / 2) - localPoint.x, (height / 2) - localPoint.y);
    var mapCenter = map.project(map.center);
    var point = mapCenter - localPointCenterDistance;
    return map.unproject(point);
  }
}
