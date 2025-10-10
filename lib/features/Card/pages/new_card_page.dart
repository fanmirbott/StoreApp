import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/features/Card/managers/cards/card_bloc.dart';
import '../managers/cards/card_state.dart';
import '../widget/text_field_add_card.dart';
import '../widget/text_field_card_data.dart';
import '../widget/text_field_cvc.dart';

String normalizeExpiryDate(String date) {
  if (date.length >= 7 && date.contains('-')) {
    final parts = date.split('-');
    if (parts.length == 3) {
      final year = parts[0].substring(2);
      final month = parts[1];
      return '$month/$year';
    }
  }
  return date;
}

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
    cardNumberController.dispose();
    cardDateController.dispose();
    cardCvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardBloc, CardState>(
      listener: (context, state) {
        if (state.createStatus == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Card added successfully')),
          );
          Navigator.pop(context);
        }
        if (state.createStatus == Status.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.createStatus == Status.loading;

        return Scaffold(
          appBar: const AppBarWidgets(text: 'New Card'),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  SizedBox(height: 20.h),
                  Text(
                    'Add Debit or Credit Card',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    children: [
                      TextFieldAddCard(
                        controller: cardNumberController,
                        text: 'Card Number',
                        hintText: 'Enter your card number',
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFieldCardData(
                              controller: cardDateController,
                              text: "Expiry Date",
                              hintText: '2025-10-08',
                            ),
                          ),
                          SizedBox(width: 11.w),
                          Expanded(
                            child: TextFieldCardCvc(
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 420.h),
                  AuthButtonOtpSend(
                    text: isLoading ? 'Adding...' : 'Add Card',
                    backgroundColor: AppColors.primary,
                    onTap: isLoading
                        ? null
                        : () {
                      final cardNumber = cardNumberController.text.trim();
                      final expiryDate = normalizeExpiryDate(cardDateController.text.trim());
                      final cvv = cardCvcController.text.trim();

                      if (cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all fields')),
                        );
                        return;
                      }

                      context.read<CardBloc>().add(
                        CardCreate(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          securityCode: cvv,
                        ),
                      );
                    },
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