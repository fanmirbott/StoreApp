import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/core/utils/result.dart';


class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final noAuthPaths = ["/auth/register", "/auth/login"];

    if (!noAuthPaths.any((path) => options.path.contains(path))) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }

    handler.next(options);
  }
}

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.71:8888/api/v1",
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  ) {
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<Result<T>> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      if (response.statusCode != 200) {
        return Result.error(Exception("${response.data}"));
      }
      return Result.ok(response.data as T);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<T>> post<T>(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return Result.error(
            Exception("Xatolik: ${response.statusCode} - ${response.data}"));
      }
      return Result.ok(response.data as T);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
