import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';

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

  @override
  void dispose() {
    super.dispose();
    controllerPassword.dispose();
    controllerEmail.dispose();
    controllerFullName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            right: 24,
            left: 24,
            top: 50,
          ),
          child: Column(
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
              SizedBox(
                height: 24.h,
              ),
              Column(
                spacing: 16,
                children: [
                  TextFieldAndText(
                    controller: controllerFullName,
                    text: 'Full Name',
                    hintText: 'Enter your full name',
                  ),
                  TextFieldAndText(
                    controller: controllerEmail,
                    text: 'Email',
                    hintText: 'Enter your email address',
                  ),
                  TextFieldAndText(
                    controller: controllerPassword,
                    text: 'Password',
                    hintText: 'Enter your password',
                    obscureText: !visiblePass,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        visiblePass = !visiblePass;
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        visiblePass == false ? AppIcons.eyeOff : AppIcons.eye,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
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
              SizedBox(
                height: 24.h,
              ),
              AuthButtonOtpSend(
                onTap: () {},
                text: 'Create an Account',
                backgroundColor: AppColors.primary400,
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.primary500,
                    ),
                  ),
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
                      height: 1,
                      color: AppColors.primary500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: 341,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.primary100),
                ),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(
                height: 16.h,
              ),
              Container(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.logosFacebook,
                    ),
                    Text(
                      'Sign Up with Google',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
