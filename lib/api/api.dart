import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio _dio;

  Api()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://10.0.2.2:5106/api',
          headers: {'Content-Type': 'application/json'},
          connectTimeout: Duration(milliseconds: 5000), // Usar Duration
          receiveTimeout: Duration(milliseconds: 3000),
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        print('Error: ${e.message}');
        if (e.response?.statusCode == 401) {
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      print('Error durante la solicitud POST: $e');
      rethrow;
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (e) {
      print('Error durante la solicitud GET: $e');
      rethrow;
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      print('Error durante la solicitud PUT: $e');
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      print('Error durante la solicitud DELETE: $e');
      rethrow;
    }
  }
}

final api = Api();
