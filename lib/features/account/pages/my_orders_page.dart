import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/account/managers/ordersBloc/orders_bloc.dart';
import 'package:storeapp/features/account/managers/ordersBloc/orders_state.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/features/common/widgets/bottom_navigation_bar_app.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List category = ['Ongoing', 'Completed'];
  int categoryIndex = 0;

  Widget _buildReviewBottomSheet(BuildContext context) {
    int selectedRating = 0;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leave a Review',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  InkWell(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.close,
                      color: AppColors.primary,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'How was your order?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Please give your rating and also your review.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary500,
                ),
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return InkWell(
                    onTap: () {
                      setModalState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        index < selectedRating ? Icons.star : Icons.star_border,
                        color: index < selectedRating ? Colors.orange : AppColors.primary100,
                        size: 36.w,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 24.h),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your review...',
                    hintStyle: TextStyle(color: AppColors.primary500),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              SizedBox(height: 24.h),

              Container(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: selectedRating > 0
                      ? () {
                    // TODO: Implement logic to submit the review
                    context.pop();
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: AppColors.white,),
          );
        }
        if (state.status == Status.initial) {
          return Center(child: CircularProgressIndicator(backgroundColor: AppColors.white,),);
        }
        if (state.status == Status.error) {
          return Center(
            child: Text("xatolik yuz berdi keyinroq qaytadan urinib ko'ring"),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<OrdersBloc>().add(OrdersGet());
          },
          child: Scaffold(
            extendBody: true,
            appBar: AppBarWidgets(text: 'My Orders'),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    width: 341.w,
                    height: 54.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.primary100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(2, (index) {
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  categoryIndex = index;
                                });
                              },
                              borderRadius: BorderRadius.circular(6.r),
                              child: Container(
                                alignment: Alignment.center,
                                height: 38.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: categoryIndex == index
                                      ? AppColors.white
                                      : AppColors.primary100,
                                ),
                                child: Text(
                                  category[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: categoryIndex == index
                                        ? AppColors.primary
                                        : AppColors.primary500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (state.orders.isEmpty && categoryIndex == 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 69),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 172.h,),

                        SvgPicture.asset(
                          AppIcons.boxDuotone,
                          width: 64.w,
                          height: 64.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 24.h,),
                        Text(
                          'No Ongoing Orders!',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        Text(
                          textAlign: TextAlign.center,
                          'You don’t have any ongoing orders at this time.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary500,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (categoryIndex == 0 && state.orders.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 100, left: 24, right: 24),
                        child: Column(
                          children: [
                            ...List.generate(state.orders.length, (index) {
                              final order = state.orders[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 14,
                                  ),
                                  width: 342.w,
                                  height: 107.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: AppColors.primary100),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.r),
                                        child: Image.network(
                                          order.image,
                                          width: 83.w,
                                          height: 79.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  order.title,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: 60.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      10.r,
                                                    ),
                                                    color: AppColors.primary100,
                                                  ),
                                                  child: Text(
                                                    order.status,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              order.size,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: AppColors.primary500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "\$ ${order.price}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: (){
                                                    context.push(Routes.trackOrder);
                                                  },
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    width: 90.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        6.r,
                                                      ),
                                                      color: AppColors.primary,
                                                    ),
                                                    child: Text(
                                                      'Track Order',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (categoryIndex == 1)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 100, left: 24, right: 24),
                        child: Column(
                          children: [
                            ...List.generate(state.orders.length, (index) {
                              final order = state.orders[index];
                              final double? rating = (index == 1 || index == 4) ? 4.5 : null;

                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 14,
                                  ),
                                  width: 342.w,
                                  height: 107.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: AppColors.primary100),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.r),
                                        child: Image.network(
                                          order.image,
                                          width: 83.w,
                                          height: 79.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  order.title,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: 68.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      6.r,
                                                    ),
                                                    color: AppColors.green500,
                                                  ),
                                                  child: Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.green,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              order.size,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: AppColors.primary500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 11.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "\$ ${order.price}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                Spacer(),
                                                if (rating != null)
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.orange,
                                                        size: 14.w,
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Text(
                                                        '${rating.toStringAsFixed(1)}/5',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.primary,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled: true,
                                                        backgroundColor: Colors.transparent,
                                                        builder: (context) => Padding(
                                                          padding: EdgeInsets.only(
                                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                                          ),
                                                          child: _buildReviewBottomSheet(context),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      alignment:
                                                      Alignment.center,
                                                      width: 90.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                          6.r,
                                                        ),
                                                        color: AppColors.primary,
                                                      ),
                                                      child: Text(
                                                        'Leave Review',
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),

              ],
            ),
            bottomNavigationBar: BottomNavigationBarApp(),
          ),
        );
      },
    );
  }
}