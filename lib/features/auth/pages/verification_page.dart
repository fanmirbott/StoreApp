import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  static const int otpLength = 4;
  final List<TextEditingController> controllers = List.generate(
    otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(
    otpLength,
    (_) => FocusNode(),
  );

  void checkOtp() {
    final code = controllers.map((c) => c.text).join();
    if (code.length == otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP entered: $code")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter 4 Digit Code",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Enter 4 digit code that you receive on your email (${widget.email}).",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(otpLength, (index) {
                return Container(
                  width: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (index < otpLength - 1) {
                          focusNodes[index + 1].requestFocus();
                        } else {
                          focusNodes[index].unfocus();
                          checkOtp();
                        }
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Email not received? ",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Resend code tapped")),
                    );
                  },
                  child: const Text(
                    "Resend code",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
           Spacer(),
            AuthButtonOtpSend(
              onTap: (){
                context.push(Routes.resetPasswordPage);
              },
              text: 'Continue',
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
