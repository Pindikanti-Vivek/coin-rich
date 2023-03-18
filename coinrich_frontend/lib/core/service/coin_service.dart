import 'package:coinrich_frontend/core/rest/api_client.dart';
import 'package:coinrich_frontend/core/rest/api_response.dart';
import 'package:coinrich_frontend/core/utils/hive_storage.dart';

class CoinService {

  Future<ApiResponse> quotes(String quoteList) async {
    return await ApiClient.instance.requestApi(api: "/coin/quotes?symbols=$quoteList", body: HiveStorage.instance.hive.get("token"), type: "GET");
  }
}