import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
