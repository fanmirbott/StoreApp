import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';

import '../managers/sign_up_view_model.dart';

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
    controllerFullName.addListener(checkFormValidity);
    controllerEmail.addListener(checkFormValidity);
    controllerPassword.addListener(checkFormValidity);
  }

  void checkFormValidity() {
    setState(() {
      isFormValid = fullNameError == null &&
          emailError == null &&
          passwordError == null &&
          controllerFullName.text.isNotEmpty &&
          controllerEmail.text.isNotEmpty &&
          controllerPassword.text.isNotEmpty;
    });
  }

  // 🔹 Validatsiya funksiyalari
  void validateFullName(String value) {
    setState(() {
      fullNameError =
      value.length < 8 ? "Full name must be at least 8 characters" : null;
    });
    checkFormValidity();
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
    checkFormValidity();
  }

  void validatePassword(String value) {
    setState(() {
      passwordError =
      value.length < 8 ? "Password must be at least 8 characters" : null;
    });
    checkFormValidity();
  }

  void validateAndSubmit() async {
    if (isFormValid) {
      final vm = context.read<SignUpViewModel>();
      final success = await vm.signUp(
        controllerFullName.text.trim(),
        controllerEmail.text.trim(),
        controllerPassword.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(vm.successMessage ?? "✅ Success!")),
        );
        context.go(Routes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(vm.errorMessage ?? "❌ Xatolik yuz berdi")),
        );
      }
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
              /// Title
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

              /// TextFields
              Column(
                spacing: 16,
                children: [
                  TextFieldAndText(
                    controller: controllerFullName,
                    text: 'Full Name',
                    hintText: 'Enter your full name',
                    errorText: fullNameError,
                    onChanged: validateFullName,
                  ),
                  TextFieldAndText(
                    controller: controllerEmail,
                    text: 'Email',
                    hintText: 'Enter your email address',
                    errorText: emailError,
                    onChanged: validateEmail,
                  ),
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
                onTap: validateAndSubmit,
                text: 'Create an Account',
                backgroundColor:
                isFormValid ? Colors.black : AppColors.primary400,
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
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.logosGoogleIcon),
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
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.logosFacebook),
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
  }
}
