import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/home/widgets/bottom_navigation_bar_app.dart';
import 'package:storeapp/features/home/widgets/counter_row_vidget.dart';

import '../../../core/utils/status.dart';
import '../../home/managers/cart/cart_bloc.dart';
import '../../home/managers/cart/cart_state.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppIcons.backArrow),
        ),
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.bell),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == Status.error) {
            return Center(
              child: Text(state.errorMessage ?? "Xatolik yuz berdi"),
            );
          }

          if (state.cart == null || state.cart!.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.cartDuotone,
                    width: 64.w,
                    height: 64.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Your Cart Is Empty!',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'When you add products, they’ll',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary500,
                    ),
                  ),
                  Text(
                    'appear here.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary500,
                    ),
                  ),
                ],
              ),
            );
          }

          final cart = state.cart!;
          return Padding(
            padding: EdgeInsetsGeometry.only(right: 24, left: 24, bottom: 20, top: 10),
            child: Column(
              children: [
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    spacing: 14,
                    children: [
                      ...List.generate(
                        state.cart!.items.length,
                            (index) {
                          return Container(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 15,
                              vertical: 14,
                            ),
                            width: 342.w,
                            height: 107.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary200,
                              ),
                              borderRadius: BorderRadiusGeometry.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  cart.items[index].image,
                                  width: 83.w,
                                  height: 79.h,
                                  fit: BoxFit.cover,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cart.items[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      "Size ${cart.items[index].size}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$ ${cart.items[index].price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        AppIcons.trash,
                                        width: 16.w,
                                        height: 16.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Spacer(),
                                    CounterRow(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(),
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
                    SizedBox(height: 35,),
                    GestureDetector(
                      onTap: (){
                        context.push(Routes.paymentMethodPage);
                      },
                      child: Container(
                        width: 341.w,
                        height: 54.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go To Checkout',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                            SvgPicture.asset(AppIcons.arrowRight),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}
