import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio _dio;

  Api()
      : _dio = Dio(BaseOptions(
          baseUrl: "http://10.0.2.2:5106/api", // Reemplaza con tu URL base
          headers: {'Content-Type': 'application/json'},
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Obtener el token desde SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response); // Lógica de éxito
      },
      onError: (DioError e, handler) async {
        // Manejo de errores global
        // print error
        print('Error: ${e.message}');
        if (e.response?.statusCode == 401) {
          // Aquí podrías redirigir a la pantalla de login o eliminar el token si ha expirado
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          // Navegar al login
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) {
    return _dio.post(path, data: data);
  }

  // Agregar más métodos (GET, PUT, DELETE) según lo necesites
}

final api = Api();
