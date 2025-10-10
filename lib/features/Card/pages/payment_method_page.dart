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
import 'package:storeapp/features/Card/managers/cards/card_bloc.dart';
import '../../../data/repositories/card_repository.dart';
import '../managers/cards/card_state.dart';
import '../widget/add_card_button.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedCard;

  void _showDeleteConfirmation(BuildContext context, dynamic card) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text('Kartani o‘chirish: **** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}', style: const TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  context.read<CardBloc>().add(CardDelete(cardId: card.id));
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Bekor qilish'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardBloc(
        cardRepo: context.read<CardRepository>(),
      ),
      child: BlocConsumer<CardBloc, CardState>(
        listener: (context, state) {
          if (state.deleteStatus == Status.error && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Delete Error: ${state.errorMessage}')),
            );
          }
          if (state.deleteStatus == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Karta muvaffaqiyatli o‘chirildi.')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == Status.loading && state.cards.isEmpty) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == Status.error && state.cards.isEmpty) {
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
              padding: EdgeInsets.only(right: 24, left: 24, bottom: 40.h),
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
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: InkWell(
                            onLongPress: () {
                              _showDeleteConfirmation(context, card);
                            },
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: (){
                              setState(() {
                                selectedCard = masked;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: selectedCard == masked ? AppColors.primary : AppColors.primary100,
                                ),
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
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AddCardButton(
                    onTap: () async {
                      await context.push(Routes.newCardPage);
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