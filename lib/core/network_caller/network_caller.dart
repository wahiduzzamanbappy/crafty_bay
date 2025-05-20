import 'dart:convert';
import '../../features/auth/ui/controllers/auth_controller.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong!',
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      url += '?';
      for (String key in queryParams?.keys ?? {}) {
        url += '$key=${queryParams![key]}&';
      }
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'token': getx.Get.find<AuthController>().token ?? ''};

      _logRequest(url, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token': getx.Get.find<AuthController>().token ?? ''
      };

      _logRequest(url, headers);
      Response response =
      await post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> putRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token': getx.Get.find<AuthController>().token ?? ''
      };

      _logRequest(url, headers);
      Response response =
      await put(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token': getx.Get.find<AuthController>().token ?? ''
      };

      _logRequest(url, headers);
      Response response =
      await patch(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token': getx.Get.find<AuthController>().token ?? ''
      };

      _logRequest(url, headers);
      Response response =
      await delete(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse);
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, Map<String, dynamic> headers,
      {Map<String, dynamic>? requestBody}) {
    _logger.i("URL => $url\nHeaders: $headers\nBody: $requestBody");
  }

  void _logResponse(String url, Response response) {
    _logger.i(
        "URL => $url\nStatus Code: ${response.statusCode}\nHeaders: ${response.headers}\nBody: ${response.body}");
  }

  Future<void> _clearUserData() async {
    await getx.Get.find<AuthController>().clearUserData();
  }
}
