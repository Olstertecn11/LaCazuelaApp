import 'package:dio/dio.dart';
import 'package:lacazuela_mobile/api/api.dart';

class HandleRequest {
  static Future<Map<String, dynamic>> request<T>(Future<Response> Function() request) async {
    try {
      final response = await request();
      return {
        'status': response.statusCode,
        'data': response.data,
        'error': null,
      };
    } catch (error) {
      if (error is DioError && error.response != null) {
        return {
          'status': error.response?.statusCode,
          'data': null,
          'error': error.response?.data ?? {'message': error.message},
        };
      } else {
        return {
          'status': null,
          'data': null,
          'error': {'message': 'No response from server', 'details': error.toString()},
        };
      }
    }
  }
}
