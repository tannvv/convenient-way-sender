import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:convenient_way_sender/app/config/build_config.dart';

mixin BaseWidgetMixin on StatelessWidget {
  final Logger logger = BuildConfig.instance.config.logger;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }

  Widget body(BuildContext context);
}
