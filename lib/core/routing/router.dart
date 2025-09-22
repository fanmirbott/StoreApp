import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/data/repositories/auth/reset_email_repository.dart';
import 'package:storeapp/features/auth/managers/reset_email_view_model.dart';
import 'package:storeapp/features/auth/pages/forgot_password_page.dart';
import 'package:storeapp/features/auth/pages/login_page.dart';
import 'package:storeapp/features/auth/pages/reset_password_page.dart';
import 'package:storeapp/features/auth/pages/sign_up_page.dart';
import 'package:storeapp/features/auth/pages/verification_page.dart';
import 'package:storeapp/features/home/pages/home_page.dart';
import 'package:storeapp/features/home/pages/notification_page.dart';
import 'package:storeapp/features/home/pages/product_detail_page.dart';
import 'package:storeapp/features/obBoarding/pages/onboarding_page.dart';
import 'package:storeapp/features/obBoarding/pages/splash.dart';
import 'package:storeapp/features/obBoarding/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: Routes.homePage,
  routes: [
    ShellRoute(
      builder: (context, state, child) => ChangeNotifierProvider(
        create: (context) =>
            ResetEmailViewModel(ResetEmailRepository(client: ApiClient())),
        child: child,
      ),
      routes: [
        GoRoute(
          path: Routes.forgotPasswordPage,
          builder: (context, state) => ForgotPasswordPage(),
        ),
        GoRoute(
          path: Routes.verificationPage,
          builder: (context, state) {
            final email = state.extra as String;
            return VerificationPage(email: email);
          },
        ),
        GoRoute(
          path: Routes.resetPasswordPage,
          builder: (context, state) => ResetPasswordPage(),
        ),
      ],
    ),
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
    GoRoute(
      path: Routes.homePage,
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => Splash(),
    ),
    GoRoute(
      path: Routes.notificationPage,
      builder: (context, state) => NotificationPage(),
    ),
    GoRoute(
      path: Routes.productDetailPage,
      builder: (context, state) => ProductDetailPage(),
    ),
  ],
);
