import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';

import '../managers/authBloc/auth_bloc.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controllerFullName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  bool visiblePass = false;

  String? fullNameError;
  String? emailError;
  String? passwordError;

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    controllerFullName.addListener(_updateFormValidity);
    controllerEmail.addListener(_updateFormValidity);
    controllerPassword.addListener(_updateFormValidity);
  }

  void _updateFormValidity() {
    setState(() {
      isFormValid = fullNameError == null &&
          emailError == null &&
          passwordError == null &&
          controllerFullName.text.isNotEmpty &&
          controllerEmail.text.isNotEmpty &&
          controllerPassword.text.isNotEmpty;
    });
  }

  void validateFullName(String value) {
    setState(() {
      if (value.isEmpty) {
        fullNameError = "Full name is required";
      } else if (value.length < 8) {
        fullNameError = "Full name must be at least 8 characters";
      } else {
        fullNameError = null;
      }
    });
    _updateFormValidity();
  }

  void validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        emailError = "Email is required";
      } else if (!value.endsWith("@gmail.com")) {
        emailError = "Email must end with @gmail.com";
      } else if (value.length < 8) {
        emailError = "Email must be at least 8 characters";
      } else {
        emailError = null;
      }
    });
    _updateFormValidity();
  }

  void validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        passwordError = "Password is required";
      } else if (value.length < 8) {
        passwordError = "Password must be at least 8 characters";
      } else {
        passwordError = null;
      }
    });
    _updateFormValidity();
  }

  void validateAndSubmit() {
    if (isFormValid) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          controllerFullName.text.trim(),
          controllerEmail.text.trim(),
          controllerPassword.text.trim(),
        ),
      );
    }
  }


  @override
  void dispose() {
    controllerPassword.dispose();
    controllerEmail.dispose();
    controllerFullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == Status.success && state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account created successfully!")),
          );
          context.go(Routes.homePage);
        }
        else if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errorMessage ?? "Registration failed")),
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
                top: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'Let’s create your account.',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    children: [
                      TextFieldAndText(
                        controller: controllerFullName,
                        text: 'Full Name',
                        hintText: 'Enter your full name',
                        errorText: fullNameError,
                        onChanged: validateFullName,
                      ),
                      SizedBox(height: 16.h),
                      TextFieldAndText(
                        controller: controllerEmail,
                        text: 'Email',
                        hintText: 'Enter your email address',
                        errorText: emailError,
                        onChanged: validateEmail,
                      ),
                      SizedBox(height: 16.h),
                      TextFieldAndText(
                        controller: controllerPassword,
                        text: 'Password',
                        hintText: 'Enter your password',
                        obscureText: !visiblePass,
                        errorText: passwordError,
                        onChanged: validatePassword,
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
                    ],
                  ),
                  SizedBox(height: 12.h),
                  RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      text: "By signing up you agree to our ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Terms",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ", "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ", and "),
                        TextSpan(
                          text: "Cookie Use",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  AuthButtonOtpSend(
                    onTap: (isFormValid && !isLoading) ? validateAndSubmit : null,
                    text: isLoading ? 'Loading...' : 'Create an Account',
                    backgroundColor: (isFormValid && !isLoading)
                        ? Colors.black
                        : AppColors.primary400,
                  ),

                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: 1, color: AppColors.primary500)),
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
                          child: Container(
                              height: 1, color: AppColors.primary500)),
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
                  SizedBox(height: 48.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?  ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(Routes.loginPage);
                              },
                            text: "Log In",
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