import 'package:convenient_way_sender/app/core/controllers/cw_map_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/data/constants/notification_type.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';

class TrackingPackageController extends GetxController {
  Package package = Get.arguments as Package;
  final AuthController _authController = Get.find<AuthController>();
  LatLng? locationStart;
  LatLng? locationEnd;
  Rx<LatLng?> locationDeliver = Rx(null);
  LatLngBounds currentBounds = LatLngBounds();
  final CwMapController cwMapController = CwMapController();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    locationStart = LatLng(package.startLatitude!, package.startLongitude!);
    locationEnd =
        LatLng(package.destinationLatitude!, package.destinationLongitude!);
    onTracking();
  }

  void onMapReady() async {
    await cwMapController.refreshCurrentLocation();
    createBounds();
  }

  void gotoCurrentBound() {
    cwMapController.centerZoomFitBounds(currentBounds);
  }

  void createBounds() {
    currentBounds = LatLngBounds(locationStart, locationEnd);
    gotoCurrentBound();
  }

  void onTracking() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['typeOfNotification'] == TypeOfNotification.TRACKING) {
        if (message.data['deliverId'] == package.deliverId) {
          locationDeliver.value = LatLng(
              double.parse(message.data['latitude']!),
              double.parse(message.data['longitude']!));
        }
      }
    });
  }
}
