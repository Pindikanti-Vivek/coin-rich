import 'package:coinrich_frontend/core/config/colors.dart';
import 'package:coinrich_frontend/core/config/styles.dart';
import 'package:coinrich_frontend/core/utils/hive_storage.dart';
import 'package:coinrich_frontend/presentation/base/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: Text("CoinRich", style: kText30Bold.copyWith(color: kWhiteColor)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Center(child: Text("Welcome ${HiveStorage.instance.hive.get("username")}", style: kText24Normal)),
        ],
      ).paddingAll(12),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          LoadingController.instance.loading.value = true;
          Get.toNamed("/coin");
        },
        label: const Text("Check Coins"),
      ),
    );
  }
}
