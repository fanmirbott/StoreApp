import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/data/repositories/auth/reset_email_repository.dart';
import 'package:storeapp/features/account/pages/account_page.dart';
import 'package:storeapp/features/account/pages/faqs_page.dart';
import 'package:storeapp/features/account/pages/help_center_page.dart';
import 'package:storeapp/features/account/pages/my_details_page.dart';
import 'package:storeapp/features/account/pages/notifications_settings_page.dart';
import 'package:storeapp/features/auth/managers/reset_email_view_model.dart';
import 'package:storeapp/features/auth/pages/forgot_password_page.dart';
import 'package:storeapp/features/auth/pages/login_page.dart';
import 'package:storeapp/features/auth/pages/reset_password_page.dart';
import 'package:storeapp/features/auth/pages/sign_up_page.dart';
import 'package:storeapp/features/auth/pages/verification_page.dart';
import 'package:storeapp/features/Card/pages/new_card_page.dart';
import 'package:storeapp/features/cartPage/pages/my_cart_page.dart';
import 'package:storeapp/features/home/pages/home_page.dart';
import 'package:storeapp/features/home/pages/notification_page.dart';
import 'package:storeapp/features/home/pages/product_detail_page.dart';
import 'package:storeapp/features/home/pages/reviews_page.dart';
import 'package:storeapp/features/obBoarding/pages/onboarding_page.dart';
import 'package:storeapp/features/obBoarding/pages/splash.dart';
import 'package:storeapp/features/obBoarding/pages/splash_page.dart';
import 'package:storeapp/features/saved/pages/saved_items_page.dart';
import 'package:storeapp/features/search/pages/search_page.dart';
import '../../features/Card/pages/payment_method_page.dart';

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
      builder: (context, state) {
        final productId = state.extra as int;
        return ProductDetailPage(productId: productId);
      },
    ),
    GoRoute(
      path: Routes.searchPage,
      builder: (context, state) => SearchPage(),
    ),
    GoRoute(
      path: Routes.savedPage,
      builder: (context, state) => SavedItemsPage(),
    ),
    GoRoute(
      path: Routes.cartPage,
      builder: (context, state) => MyCartPage(),
    ),
    GoRoute(
      path: Routes.accountPage,
      builder: (context, state) => AccountPage(),
    ),
    GoRoute(
      path: Routes.reviewsPage,
      builder: (context, state) => ReviewsPage(),
    ),
    GoRoute(
      path: Routes.helpCenterPage,
      builder: (context, state) => HelpCenterPage(),
    ),
    GoRoute(
      path: Routes.paymentMethodPage,
      builder: (context, state) => PaymentMethodPage(),
    ),
    GoRoute(
      path: Routes.newCardPage,
      builder: (context, state) => NewCardPage(),
    ),
    GoRoute(
      path: Routes.notificationsSettingsPage,
      builder: (context, state) => NotificationsSettingsPage(),
    ),
    GoRoute(
      path: Routes.myDetailsPage,
      builder: (context, state) => MyDetailsPage(),
    ),
    GoRoute(
      path: Routes.faqsPage,
      builder: (context, state) => FaqsPage(),
    ),
  ],
);
