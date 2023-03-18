import 'package:coinrich_frontend/core/rest/api_response.dart';
import 'package:coinrich_frontend/core/service/user_service.dart';
import 'package:coinrich_frontend/core/utils/hive_storage.dart';
import 'package:coinrich_frontend/presentation/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final UserService userService;

  LoginController(this.userService);

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final usernameError = Rxn<String>();
  final passwordError = Rxn<String>();
  final confirmPasswordError = Rxn<String>();
  final signup = false.obs;
  final enabled = false.obs;

  Future<void> onSignup() async {
    validateUsername();
    validatePassword();
    validateConfirmPassword();
    if(usernameError.value == null && passwordError.value == null && confirmPasswordError.value == null) {
      ApiResponse response = await userService.signup(username.text, password.text);
      if (response.isSuccess) {
        toast("Signup Successful",type: "Success");
        signup.value = false;
      }
    }
  }

  Future<void> onLogin() async {
    validateUsername();
    validatePassword();
    if(usernameError.value == null && passwordError.value == null) {
      ApiResponse response = await userService.login(username.text, password.text);
      if (response.isSuccess) {
        toast("Login Successful",type: "Success");
        HiveStorage.instance.hive.put("username", username.text);
        HiveStorage.instance.hive.put("token", response.responseBody["response"]);
        Get.toNamed("/home");
      }
    }
  }

  void validateUsername() {
    if(username.text.length < 4) {
      usernameError.value = "Username should be at least 4 characters";
    } else {
      usernameError.value = null;
    }
  }

  void validatePassword() {
    if(password.text.length < 8) {
      passwordError.value = "Password should be at least 8 characters";
    } else if (!RegExp("[a-z]").hasMatch(password.text)) {
      passwordError.value = "Password should contain at least 1 lower case letter";
    } else if (!RegExp("[A-Z]").hasMatch(password.text)) {
      passwordError.value = "Password should contain at least 1 upper case letter";
    } else if (!RegExp("[0-9]").hasMatch(password.text)) {
      passwordError.value = "Password should contain at least 1 numeric letter";
    } else if (!RegExp("\\W").hasMatch(password.text)) {
      passwordError.value = "Password should contain at least 1 special character";
    } else {
      passwordError.value = null;
    }
  }

  void validateConfirmPassword() {
    if(password.text != confirmPassword.text) {
      confirmPasswordError.value = "Password not matching";
    } else {
      confirmPasswordError.value = null;
    }
  }

}