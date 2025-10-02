import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';
import 'package:storeapp/features/cartPage/widget/text_field_add_card.dart';
import 'package:storeapp/features/cartPage/widget/text_field_card_data.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';

import '../widget/text_field_cvc.dart';

class NewCardPage extends StatefulWidget {
  const NewCardPage({super.key});

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  final cardNumberController = TextEditingController();
  final cardDateController = TextEditingController();
  final cardCvcController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cardNumberController.dispose();
    cardDateController.dispose();
    cardCvcController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(text: 'New Card'),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsetsGeometry.only(right: 24, left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Add Debit or Credit Card',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),

              Column(
                spacing: 16,
                children: [
                  TextFieldAddCard(
                    controller: cardNumberController,
                    text: 'Card NUmber',
                    hintText: 'Enter your card number',
                  ),
                  Row(
                    spacing: 11,
                    children: [
                      TextFieldCardData(
                        controller: cardDateController,
                        text: "Expiry Date",
                        hintText: 'MM/YY',
                      ),
                      TextFieldCardCvc(
                        controller: cardCvcController,
                        text: "Security Code",
                        hintText: 'CVC',
                        suffixIcon: SvgPicture.asset(
                          AppIcons.question,
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 420.h,),
              AuthButtonOtpSend(
                onTap: () {
                  final cardNumber = cardNumberController.text.trim();
                  if (cardNumber.isNotEmpty && cardNumber.length >= 4) {
                    final card = "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
                    Navigator.pop(context, card);
                  }
                },
                text: 'Add Card',
                backgroundColor: AppColors.primary,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
