import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/data/repositories/card/card_list_repository.dart';
import 'package:storeapp/features/Card/managers/cardsGet/card_bloc.dart';
import 'package:storeapp/features/Card/managers/cardsGet/card_state.dart';
import '../widget/add_card_button.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedCard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc(
        cardRepo: context.read<CardListRepository>(),
      )..add(CardLoading()),
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.error) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.errorMessage ?? 'Xatolik yuz berdi',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          final cards = state.cards;
          return Scaffold(
            appBar: const AppBarWidgets(text: 'Payment Method'),
            body: Padding(
              padding: EdgeInsetsGeometry.only(right: 24, left: 24, bottom: 40),
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
                  if (cards.isEmpty)
                    const Text("Hali karta qo‘shilmagan"),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        final masked = card.cardNumber.length >= 4
                            ? '**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}'
                            : card.cardNumber;
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
                              Text(masked),
                              const Spacer(),
                              Radio<String>(
                                value: masked,
                                groupValue: selectedCard,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCard = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  AddCardButton(
                    onTap: () async {
                      final newCard = await context.push(Routes.newCardPage);
                      if (newCard != null && newCard is String) {
                        context.read<CardBloc>().add(CardLoading());
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
