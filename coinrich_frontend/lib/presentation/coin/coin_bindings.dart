import 'package:coinrich_frontend/core/service/coin_service.dart';
import 'package:coinrich_frontend/presentation/coin/coin_controller.dart';
import 'package:get/get.dart';

class CoinBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CoinService());
    Get.put(CoinController(Get.find<CoinService>()));

  }
}