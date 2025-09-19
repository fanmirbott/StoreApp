import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../widgets/text_field_and_text.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final controllerPassword = TextEditingController();
  final controllerConfirmPass = TextEditingController();
  bool visiblePass = false;

  @override
  void dispose() {
    super.dispose();
    controllerPassword.dispose();
    controllerConfirmPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: SvgPicture.asset(AppIcons.backArrow),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(right: 24, left: 24),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Set the new password for your account so you can login and access all the features.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary500,
                  ),
                ),
              ],
            ),
            TextFieldAndText(
              obscureText: !visiblePass,
              controller: controllerPassword,
              text: 'Password',
              hintText: 'Enter your password',
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
            TextFieldAndText(
              obscureText: !visiblePass,
              controller: controllerConfirmPass,
              text: 'Confirm Password',
              hintText: 'Enter your password',
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
      ),
    );
  }
}
