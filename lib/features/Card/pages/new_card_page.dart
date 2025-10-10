import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/auth/widgets/auth_button_otp_send.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import '../managers/cardCreate/card_create_bloc.dart';
import '../managers/cardCreate/card_create_event.dart';
import '../managers/cardCreate/card_create_state.dart';
import '../widget/text_field_add_card.dart';
import '../widget/text_field_card_data.dart';
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
    cardNumberController.dispose();
    cardDateController.dispose();
    cardCvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCreateBloc, CardCreateState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Card added successfully')),
            );

            final cardNumber = cardNumberController.text.trim();
            final card =
                "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
            Navigator.pop(context, card);
          },
          failure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $error')),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

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
                    spacing: 16,
                    children: [
                      TextFieldAddCard(
                        controller: cardNumberController,
                        text: 'Card Number',
                        hintText: 'Enter your card number',
                      ),
                      Row(
                        spacing: 11,
                        children: [
                          TextFieldCardData(
                            controller: cardDateController,
                            text: "Expiry Date",
                            hintText: '2025-10-08',
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

                      context.read<CardCreateBloc>().add(
                        CardCreateEvent.create(
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
