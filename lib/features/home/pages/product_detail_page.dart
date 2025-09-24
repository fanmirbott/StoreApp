import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/home/managers/productDetail/product_detail_bloc.dart';
import 'package:storeapp/features/home/managers/productDetail/product_detail_state.dart';
import '../../../core/utils/icons.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc(detailRepository: context.read())
            ..add(ProductDetailLoading(id: widget.productId)),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return const Center(
                child: Text('Xatolik!'),
              );
            case Status.success:
              final product = state.productDetails!;
              return Scaffold(
                extendBody: true,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(AppIcons.backArrow),
                  ),
                  centerTitle: true,
                  title: const Text(
                    'Details',
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
                body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 24.w,
                      left: 24.w,
                      top: 15.h,
                      bottom: 120.h,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            product.productImages.first.image,
                            width: 341.w,
                            height: 368.53.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 13.h),
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.starRating),
                                SizedBox(width: 2.w),
                                Text(
                                  "${product.rating.toStringAsFixed(1)}/5",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "(${product.reviewsCount} reviews)",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 13.h),
                            Text(
                              product.description,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary500,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose size',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                ...List.generate(
                                  product.productSizes.length,
                                  (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 50.w,
                                          height: 50.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                            border: Border.all(
                                              color: AppColors.primary200,
                                            ),
                                          ),
                                          child: Text(
                                            product.productSizes[index].title,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                  width: double.infinity,
                  height: 105.h,
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: AppColors.primary500,
                            ),
                          ),
                          Text(
                            "\$ ${product.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 240.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.bag),
                            SizedBox(width: 10.w),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
