import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/features/auth/pages/login_page.dart';
import 'package:storeapp/features/auth/pages/sign_up_page.dart';
import 'package:storeapp/features/obBoarding/pages/onboarding_page.dart';
import 'package:storeapp/features/obBoarding/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: Routes.splashPage,
  routes: [
    GoRoute(
      path: Routes.onBoarding,
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      path: Routes.splashPage,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: Routes.signUpPage,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: Routes.loginPage,
      builder: (context, state) => LoginPage(),
    ),
  ],
);
