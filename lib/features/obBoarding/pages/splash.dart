import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/secure_storege.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));

    await AuthStorage.deleteToken();
    print("🧹 Token tozalandi (test uchun)");

    final token = await AuthStorage.getToken();
    print("🔍 Token: $token");

    if (token == null || token.isEmpty) {
      if (!mounted) return;
      context.go(Routes.loginPage);
    } else {
      if (!mounted) return;
      context.go(Routes.homePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
