import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/Card/managers/cardsGet/card_bloc.dart';
import 'package:storeapp/features/Card/managers/cardsGet/card_state.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_bloc.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_state.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/cartPage/managers/cart/cart_bloc.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';

import '../../../core/utils/icons.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final controllerPromocode = TextEditingController();

  List paymentItem = [
    AppIcons.cardDuotone,
    AppIcons.cash,
    AppIcons.logosApplePay,
  ];
  List payText = ['Card', 'Cash', ''];
  int selectPay = 0;

  @override
  void dispose() {
    controllerPromocode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, addressState) => BlocBuilder<CardBloc, CardState>(
        builder: (context, cardState) => BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (addressState.status == Status.loading &&
                cartState.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (addressState.status == Status.error &&
                cartState.status == Status.error) {
              return Center(
                child: Text("Xatolik yuz berdi"),
              );
            }
            if (addressState.address.isEmpty && cartState.cart == null) {
              return Text('Malumotlar topilmadi! ');
            }
            final address = addressState.address;
            final cart = cartState.cart;
            if (address.isEmpty || cart == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBarWidgets(text: 'Checkout'),
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                  child: Column(
                    spacing: 20,
                    children: [
                      Column(
                        spacing: 8,
                        children: [
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'Delivery Address',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: (){
                                  context.push(Routes.addressPage);
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.location,
                            width: 24.w,
                            height: 24.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                address.first.title,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                address.last.fullAddress,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        spacing: 16,
                        children: [
                          Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              ...List.generate(paymentItem.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectPay = index;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      horizontal: 25,
                                    ),
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: selectPay != index
                                            ? AppColors.primary100
                                            : AppColors.transparent,
                                      ),
                                      color: selectPay == index
                                          ? AppColors.primary
                                          : AppColors.transparent,
                                    ),
                                    child: Row(
                                      spacing: 6,
                                      children: [
                                        SvgPicture.asset(
                                          paymentItem[index],
                                          colorFilter: ColorFilter.mode(
                                            selectPay == index
                                                ? AppColors.white
                                                : AppColors.primary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          payText[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: selectPay == index
                                                ? AppColors.white
                                                : AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                        width: 341.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.primary100),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.bxlVisa,
                              width: 144.w,
                              height: 14.h,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              '**** **** **** ${cardState.cards.first.cardNumber.substring(14)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                context.push(Routes.paymentMethodPage);
                              },
                              borderRadius: BorderRadius.circular(50.r),
                              child: SvgPicture.asset(
                                AppIcons.edit,
                                width: 24.w,
                                height: 24.h,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Column(
                        spacing: 16,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sub-total',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AppColors.primary500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$ ${cart.subTotal}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'VAT (%)',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AppColors.primary500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$ ${cart.vat}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Shipping fee',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AppColors.primary500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$ ${cart.shippingFee}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$ ${cart.total}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 279,
                                child: TextField(
                                  controller: controllerPromocode,
                                  decoration: InputDecoration(
                                    hintText: 'Enter promo code',
                                    hintStyle: TextStyle(color: AppColors.primary200),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: AppColors.primary100
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),

                              ),
                              Spacer(),
                              ButtonWidget(
                                width: 84.w,
                                onTap: () {},
                                text: 'Add',
                                buttonColor: AppColors.primary,
                                textColor: AppColors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          ButtonWidget(
                            width: 341.w,
                            onTap: () {},
                            text: 'Place Order',
                            buttonColor: AppColors.primary,
                            textColor: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
