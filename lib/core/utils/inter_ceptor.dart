import 'package:dio/dio.dart';
import 'package:storeapp/core/utils/secure_storege.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final noAuthPaths = ["/auth/register", "/auth/login"];

    if (!noAuthPaths.any((path) => options.path.contains(path))) {
      final token = await AuthStorage.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }

    handler.next(options);
  }
}
