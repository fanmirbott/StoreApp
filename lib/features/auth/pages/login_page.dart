import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/data/repositories/auth/login_repository.dart';
import 'package:storeapp/features/auth/managers/login_view_model.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';

// Bu LoginPage faqat Providerni rootda o'rnatadi
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(LoginRepository(client: ApiClient())),
      child: const _LoginPageContent(),
    );
  }
}

class _LoginPageContent extends StatefulWidget {
  const _LoginPageContent({super.key});

  @override
  State<_LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  bool visiblePass = false;
  String? emailError;
  String? passwordError;

  bool get isFormValid =>
      emailError == null &&
          passwordError == null &&
          controllerEmail.text.isNotEmpty &&
          controllerPassword.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(_validateEmail);
    controllerPassword.addListener(_validatePassword);
  }

  void _validateEmail() {
    final email = controllerEmail.text;
    setState(() {
      if (email.isEmpty) {
        emailError = "Email bo'sh bo'lishi mumkin emas";
      } else if (!email.endsWith("@gmail.com")) {
        emailError = "Faqat @gmail.com bilan tugashi kerak";
      } else {
        emailError = null;
      }
    });
  }

  void _validatePassword() {
    final password = controllerPassword.text;
    setState(() {
      if (password.isEmpty) {
        passwordError = "Parol bo'sh bo'lishi mumkin emas";
      } else if (password.length < 8) {
        passwordError = "Parol kamida 8 ta belgidan iborat bo'lishi kerak";
      } else {
        passwordError = null;
      }
    });
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  // Login tugmasi bosilganda ishlaydi
  void _onLogin() async {
    if (!isFormValid) return;

    final loginViewModel = context.read<LoginViewModel>();

    await loginViewModel.login(controllerEmail.text, controllerPassword.text);

    if (loginViewModel.token != null) {
      // Token muvaffaqiyatli saqlangan, HomePage-ga o'tish
      context.go(Routes.homePage);
    } else {
      // Xatolik bo'lsa SnackBar bilan ko'rsatish
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginViewModel.errorMessage ?? 'Login xato')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, value, child) => Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              top: 60,
              bottom: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'It’s great to see you again.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary500,
                  ),
                ),
                SizedBox(height: 24.h),
                TextFieldAndText(
                  controller: controllerEmail,
                  text: "Email",
                  hintText: 'Enter your email address',
                  errorText: emailError,
                ),
                SizedBox(height: 16.h),
                TextFieldAndText(
                  obscureText: !visiblePass,
                  controller: controllerPassword,
                  text: 'Password',
                  hintText: 'Enter your password',
                  errorText: passwordError,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      visiblePass = !visiblePass;
                      setState(() {});
                    },
                    child: SvgPicture.asset(
                      visiblePass ? AppIcons.eye : AppIcons.eyeOff,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "Forgot your password?   ",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(Routes.forgotPasswordPage);
                          },
                        text: "Reset your password",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                AuthButtonOtpSend(
                  onTap: isFormValid ? _onLogin : null,
                  text: 'Login',
                  backgroundColor:
                  isFormValid ? AppColors.primary400 : Colors.grey,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                        child: Container(height: 1, color: AppColors.primary500)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "or",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(height: 1, color: AppColors.primary500)),
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 341,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primary100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.logosGoogleIcon),
                              SizedBox(width: 10.w),
                              Text(
                                'Sign Up with Google',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 341,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primary100),
                            color: AppColors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.logosFacebook),
                              SizedBox(width: 10.w),
                              Text(
                                'Sign Up with Facebook',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 164.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account?  ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(Routes.signUpPage);
                            },
                          text: "Join",
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
