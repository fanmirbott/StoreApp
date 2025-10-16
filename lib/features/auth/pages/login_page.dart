import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../managers/authBloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginPageContent();
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

  void _onLogin() {
    if (!isFormValid) return;

    context.read<AuthBloc>().add(
      LoginRequested(
        controllerEmail.text,
        controllerPassword.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == Status.success && state.token != null) {
          context.go(Routes.homePage);
        }
        else if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errorMessage ?? "Noma'lum Login xatosi")),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == Status.loading;

        return Scaffold(
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
                        setState(() {
                          visiblePass = !visiblePass;
                        });
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
                    onTap: (isFormValid && !isLoading) ? _onLogin : null,
                    text: isLoading ? 'Yuklanmoqda...' : 'Login',
                    backgroundColor: (isFormValid && !isLoading)
                        ? AppColors.primary400
                        : Colors.grey,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                          child:
                          Container(height: 1, color: AppColors.primary500)),
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
                          child:
                          Container(height: 1, color: AppColors.primary500)),
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
        );
      },
    );
  }
}