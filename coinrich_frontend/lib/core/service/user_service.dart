import 'package:coinrich_frontend/core/rest/api_client.dart';
import 'package:coinrich_frontend/core/rest/api_response.dart';

class UserService {
  Future<ApiResponse> signup(String username, String password) async {
    final Map request = {
      "username": username,
      "password": password,
    };
    return await ApiClient.instance.requestApi(api: "/user/signup", body: request);
  }

  Future<ApiResponse> login(String username, String password) async {
    final Map request = {
      "username": username,
      "password": password,
    };
    return await ApiClient.instance.requestApi(api: "/user/login", body: request);
  }
}
