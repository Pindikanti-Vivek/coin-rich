import 'dart:convert';

import 'package:coinrich_frontend/core/config/constants.dart';
import 'package:coinrich_frontend/core/rest/api_response.dart';
import 'package:coinrich_frontend/core/utils/encryption_utils.dart';
import 'package:coinrich_frontend/presentation/widgets/toast.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class ApiClient extends BaseClient {
  ApiClient._();

  static ApiClient? _instance;

  static ApiClient get instance => _instance ??= ApiClient._();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers["Content-Type"] = "application/json";
    return request.send();
  }

  Future<ApiResponse> requestApi({required String api, required dynamic body, bool showError = true, String type = "POST"}) async {
    final Uri url = Uri.parse('$kBaseUrl$api');
    final requestBody = jsonEncode(body);

    print('requestApi: api called is: ${url.toString()}');
    print('requestApi: request body is: $requestBody');

    String msgId = const Uuid().v4();
    Response response = returnResponse();
    if(type == "POST") {
      response = await post(url, body: jsonEncode({
        "content": rsaEncrypt(requestBody)
      }), headers: {
        "content-type": "application/json",
        "APP_KEY": "a3a339eb-5924-42e1-8ee8-e08c8a54f6df",
        "MSG_ID": msgId,
      });
    } else if (type == "GET") {
      response = await get(url, headers: {
        "content-type": "application/json",
        "APP_KEY": "a3a339eb-5924-42e1-8ee8-e08c8a54f6df",
        "MSG_ID": msgId,
        "token": body,
      });
    }

    print('requestApi: response status code is: ${response.statusCode}');
    print('requestApi: response body is: ${response.body}');

    if (response.body.isNotEmpty) {
      final Map responseBody = jsonDecode(response.body);
      responseBody["response"] = aesDecrypt(responseBody["response"], msgId);
      if (responseBody["status"] == "1000") {
        return ApiResponse(isSuccess: true, responseBody: responseBody);
      } else if (showError) {
        toast(responseBody["response"], type: "Fail");
        return ApiResponse(isSuccess: false, responseBody: responseBody);
      }
    } else if (showError) {
      toast("Server Error", type: "Fail");
      return ApiResponse(isSuccess: false, responseBody: {});
    }

    return ApiResponse(isSuccess: false, responseBody: {});
  }
}

Response returnResponse() {
  return Response(jsonEncode({"error": "Cannot Connect to Sever"}), 2000);
}
