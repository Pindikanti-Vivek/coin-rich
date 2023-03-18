import 'package:coinrich_frontend/presentation/base/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [child, const LoadingWidget()]);
  }
}

class LoadingWidget extends GetWidget<LoadingController> {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}