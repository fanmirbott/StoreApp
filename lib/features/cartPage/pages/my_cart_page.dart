import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:storeapp/features/home/widgets/counter_row_vidget.dart';
import 'package:storeapp/features/home/widgets/build_price_widget.dart';
import '../managers/cart/cart_bloc.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CartBloc>().add(const CartLoading());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CartBloc>().add(const CartLoading());
        },
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? "Xatolik yuz berdi"),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading && state.cart == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == Status.error && state.cart == null) {
              return Center(
                child: Text(state.errorMessage ?? "Xatolik yuz berdi"),
              );
            }

            if (state.cart == null || state.cart!.items.isEmpty) {
              return Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.cartDuotone,
                      width: 64.w,
                      height: 64.h,
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
                      'When you add products, they’ll appear here.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final cart = state.cart!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 14,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary200),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                item.image,
                                width: 83.w,
                                height: 79.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      "Size ${item.size}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "\$${item.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                        CartEvent.cartItemDeleted(
                                          productId: item.id,
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(AppIcons.trash),
                                  ),
                                  const SizedBox(height: 20),
                                  const CounterRow(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  BuildPriceWidget(
                    title: "Sub-total",
                    value: "\$${cart.subTotal}",
                  ),
                  BuildPriceWidget(
                    title: "VAT (%)",
                    value: "\$${cart.vat}",
                  ),
                  BuildPriceWidget(
                    title: "Shipping fee",
                    value: "\$${cart.shippingFee}",
                  ),
                  const Divider(),
                  BuildPriceWidget(
                    title: "Total",
                    value: "\$${cart.total}",
                  ),
                  const SizedBox(height: 25),

                  GestureDetector(
                    onTap: () => context.push(Routes.checkOutPage),
                    child: Container(
                      width: double.infinity,
                      height: 54.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
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
                          SizedBox(width: 8.w),
                          SvgPicture.asset(AppIcons.arrowRight),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}