import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';

import '../../../core/utils/icons.dart';
import '../widget/add_card_button.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {

  String? _selectedCard;
  List<String> savedCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgets(text: 'Payment Method'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Text(
              'Saved Cards',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 12.h),
            if (savedCards.isEmpty)
              const Text("Hali karta qo‘shilmagan"),
            SizedBox(height: 12.h),
            ...savedCards.map((card) {
              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primary100),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.bxlVisa),
                    SizedBox(width: 12.w),
                    Text(card),
                    const Spacer(),
                    Radio<String>(
                      value: card,
                      groupValue: _selectedCard,
                      onChanged: (value) {
                        setState(() {
                          _selectedCard = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
            AddCardButton(
              onTap: () async {
                final newCard = await context.push(Routes.newCardPage);
                if (newCard != null && newCard is String) {
                  setState(() {
                    savedCards.add(newCard);
                    _selectedCard = newCard;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

