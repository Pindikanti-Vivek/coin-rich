import 'dart:convert';

import 'package:coinrich_frontend/core/rest/api_response.dart';
import 'package:coinrich_frontend/core/service/coin_service.dart';
import 'package:coinrich_frontend/presentation/base/loading_controller.dart';
import 'package:get/get.dart';

class CoinController extends GetxController {
  final CoinService coinService;

  CoinController(this.coinService);

  List quotes = [];

  @override
  void onInit() {
    super.onInit();
    getQuotes();
  }

  Future<void> getQuotes() async {
    ApiResponse response = await coinService.quotes("BTC,ADA,ATOM,BCH,BNB,ETH,USDT");
    if(response.isSuccess) {

      Map quotesMap = jsonDecode(response.responseBody["response"])["data"];
      quotesMap.forEach((key, value) {
        quotes.add({
          "symbol": key,
          "name": value["name"],
          "rank": value["cmc_rank"],
          "price": value["quote"]["USD"]["price"].toStringAsFixed(2),
          "change": value["quote"]["USD"]["percent_change_24h"].toStringAsFixed(2),
        });
      });
    }
    LoadingController.instance.loading.value = false;
    update();
  }
}
