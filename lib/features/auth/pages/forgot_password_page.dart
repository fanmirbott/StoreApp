import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/colors.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/icons.dart';
import '../widgets/auth_button_otp_send.dart';
import '../widgets/text_field_and_text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final controllerEmail = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppIcons.backArrow),
        ),        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot password',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Enter your email for the verification process. We will send 4 digits code to your email.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.primary500,
              ),
            ),
            const SizedBox(height: 24),
            TextFieldAndText(
              controller: controllerEmail,
              text: 'Email',
              hintText: 'Enter your email address',
            ),
            const Spacer(),
            AuthButtonOtpSend(
              onTap: () {
                final email = controllerEmail.text.trim();
                if (email.isNotEmpty) {
                  context.push(
                    Routes.verificationPage,
                    extra: email, // 👈 emailni yuboramiz
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter your email")),
                  );
                }
              },
              text: "Send Code",
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
