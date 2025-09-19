import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/secure_storege.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _storage = AuthStorage();
  final _client = ApiClient();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final token = await AuthStorage.getToken();

    if (token == null || token.isEmpty) {
      _goToLogin();
      return;
    }

    final result = await _client.get<Map<String, dynamic>>("/auth/me");

    result.fold(
          (error) async {
        await AuthStorage.deleteToken();
        _goToLogin();
      },
          (data) {
        _goToHome();
      },
    );
  }

  void _goToLogin() {
    if (!mounted) return;
    context.go(Routes.loginPage);
  }

  void _goToHome() {
    if (!mounted) return;
    context.go(Routes.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
