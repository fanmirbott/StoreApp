import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/status.dart';
import '../../../data/repositories/card_repository.dart';
import '../../common/widgets/app_bar_widgets.dart';
import '../managers/cards/card_bloc.dart';
import '../managers/cards/card_event.dart';
import '../managers/cards/card_state.dart';
import '../widget/add_card_button.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int? selectedCardId;

  @override
  void initState() {
    super.initState();
    _loadDefaultCard();
  }

  Future<void> _loadDefaultCard() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('defaultCardId');
    setState(() {
      selectedCardId = id;
    });
  }

  Future<void> _saveDefaultCard(int cardId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('defaultCardId', cardId);
  }

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
                title: Text(
                  'Kartani o‘chirish: **** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.read<CardBloc>().add(CardDelete(cardId: card.id));
                  if (selectedCardId == card.id) {
                    setState(() => selectedCardId = null);
                  }
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
      create: (context) => CardBloc(cardRepo: context.read<CardRepository>()),
      child: BlocConsumer<CardBloc, CardState>(
        listener: (context, state) {
          if (state.deleteStatus == Status.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Xatolik yuz berdi')),
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
                  'Xatolik yuz berdi',
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
                  if (cards.isEmpty) const Text("Hali karta qo‘shilmagan"),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        final masked = card.cardNumber.length >= 4
                            ? '**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}'
                            : card.cardNumber;
                        final isDefault = selectedCardId == card.id;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: InkWell(
                            onLongPress: () => _showDeleteConfirmation(context, card),
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () async {
                              setState(() {
                                selectedCardId = card.id;
                              });
                              await _saveDefaultCard(card.id);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isDefault
                                      ? AppColors.primary
                                      : AppColors.primary100,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppIcons.bxlVisa),
                                  SizedBox(width: 12.w),
                                  Text(masked),
                                  SizedBox(width: 8.w),
                                  if (isDefault)
                                    Container(
                                      width: 52.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6.r),
                                        color: AppColors.primary100,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Default',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  const Spacer(),
                                  Radio<int>(
                                    value: card.id,
                                    groupValue: selectedCardId,
                                    onChanged: (value) async {
                                      setState(() {
                                        selectedCardId = value;
                                      });
                                      await _saveDefaultCard(value!);
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