import 'package:coinrich_frontend/presentation/base/loading_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoadingController());
  }
}