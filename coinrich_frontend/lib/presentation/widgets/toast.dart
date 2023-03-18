import 'package:coinrich_frontend/core/config/colors.dart';
import 'package:coinrich_frontend/core/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void toast(String message, {String type = "Info"}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(message, style: kText16Normal.copyWith(color: kWhiteColor), textAlign: TextAlign.center),
      backgroundColor: type == "Info"
          ? kNeutral9.withOpacity(0.95)
          : (type == "Success" ? kSuccessColor.withOpacity(0.95) : kFailColor.withOpacity(0.95)),
    ),
  );
}