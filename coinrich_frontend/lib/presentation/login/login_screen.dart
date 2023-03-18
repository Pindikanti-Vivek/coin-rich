import 'package:coinrich_frontend/core/config/colors.dart';
import 'package:coinrich_frontend/core/config/styles.dart';
import 'package:coinrich_frontend/presentation/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kBlackColor,
            title: Text("CoinRich", style: kText30Bold.copyWith(color: kWhiteColor)),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 100,
                child: Obx(
                  () => TextField(
                    controller: controller.username,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                    ],
                    decoration: InputDecoration(
                      labelText: "Username",
                      errorText: controller.usernameError.value,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Obx(
                  () => TextField(
                    controller: controller.password,
                    obscureText: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: controller.passwordError.value,
                    ),
                  ),
                ),
              ),
              Obx(
                () {
                  if (controller.signup.value) {
                    return SizedBox(
                      height: 100,
                      child: TextField(
                        controller: controller.confirmPassword,
                        obscureText: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          errorText: controller.confirmPasswordError.value,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.signup.value
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: kSecondaryColor),
                            onPressed: controller.onSignup,
                            child: const Text("Signup", style: kText16Normal),
                          )
                        : ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kSecondaryColor),
                            onPressed: controller.onLogin,
                            child: const Text("Login", style: kText16Normal),
                          ),
                    controller.signup.value
                        ? TextButton(
                            onPressed: () => controller.signup.value = false,
                            child: Text("Login", style: kText16Normal.copyWith(color: kLinkColor)),
                          )
                        : TextButton(
                            onPressed: () => controller.signup.value = true,
                            child: Text("Signup", style: kText16Normal.copyWith(color: kLinkColor)),
                          ),
                  ],
                ),
              )
            ],
          ).paddingAll(16),
        );
      },
    );
  }
}
