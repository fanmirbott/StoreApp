import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/features/card/widget/text_field_add_card.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/status.dart';
import '../../account/widgets/button_widget.dart';
import '../../auth/widgets/auth_button_otp_send.dart';
import '../../common/widgets/app_bar_widgets.dart';
import '../managers/cards/card_bloc.dart';
import '../managers/cards/card_event.dart';
import '../managers/cards/card_state.dart';
import '../widget/text_field_card_data.dart';
import '../widget/text_field_cvc.dart';
String normalizeExpiryDate(String input) {
  if (input.contains('/')) {
    final parts = input.split('/');
    if (parts.length == 2) {
      final month = parts[0].padLeft(2, '0');
      final year = '20${parts[1]}';
      final monthInt = int.tryParse(month) ?? 1;
      final validMonth = monthInt.clamp(1, 12).toString().padLeft(2, '0');
      return '$year-$validMonth-01';
    }
  }
  return input;
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
          context.pop();
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  content: SizedBox(
                    width: 341.w,
                    height: 270.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.checkDoutone,
                          width: 78.w,
                          height: 78.h,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          'Congratulations!',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Your new address has been added.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.primary500,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ButtonWidget(
                          width: 293.w,
                          onTap: () {
                            context.pop();
                          },
                          text: 'Thanks',
                          buttonColor: AppColors.primary,
                          textColor: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
          );
        }
        if (state.createStatus == Status.error && state.errorMessage != null) {
         Center(child: CircularProgressIndicator(),);
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
                  TextFieldAddCard(
                    controller: cardNumberController,
                    text: 'Add Debit or Credit Card',
                    hintText: 'Card Number',
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFieldCardData(
                          controller: cardDateController,
                          text: "Expiry Date",
                          hintText: 'MM/YY',
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
                  SizedBox(height: 420.h),
                  AuthButtonOtpSend(
                    text: isLoading ? 'Adding...' : 'Add Card',
                    backgroundColor: AppColors.primary,
                    onTap: isLoading
                        ? null
                        : () {
                      final cardNumber = cardNumberController.text.trim();
                      final expiryDate = normalizeExpiryDate(
                        cardDateController.text.trim(),
                      );
                      final cvv = cardCvcController.text.trim();

                      if (cardNumber.isEmpty ||
                          expiryDate.isEmpty ||
                          cvv.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                          ),
                        );
                        context.push(Routes.paymentMethodPage);
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
