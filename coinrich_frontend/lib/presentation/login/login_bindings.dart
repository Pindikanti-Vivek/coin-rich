import 'package:coinrich_frontend/core/service/user_service.dart';
import 'package:coinrich_frontend/presentation/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
    Get.put(LoginController(Get.find<UserService>()));

  }
}