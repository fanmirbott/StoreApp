import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/features/home/managers/productDetail/product_detail_bloc.dart';
import 'package:storeapp/features/home/managers/productDetail/product_detail_state.dart';
import '../../../core/utils/icons.dart';
import '../../cartPage/managers/cart/cart_bloc.dart';

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
  int? _selectedSizeId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          ProductDetailBloc(detailRepository: context.read())
            ..add(ProductDetailLoading(id: widget.productId)),
        ),
        BlocProvider(
          create: (context) =>
          CartBloc(cartRepository: context.read())
            ..add(const CartEvent.cartLoading()),
        ),
      ],
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, cartState) {
          if (cartState.status == Status.success && cartState.lastAddedItem != null) {
            // Savatga mahsulot muvaffaqiyatli qo'shildi, endi o'tamiz
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.push(Routes.cartPage);
          } else if (cartState.status == Status.error && cartState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(cartState.errorMessage!)),
            );
          }
        },
        builder: (context, cartState) {
          final isAddingToCart = cartState.status == Status.loading && cartState.lastAddedItem == null;

          return BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.loading:
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                case Status.error:
                  return const Scaffold(
                    body: Center(child: Text('Xatolik yuz berdi!')),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 13.h),
                            InkWell(
                              onTap: () => context.push(Routes.reviewsPage),
                              child: Row(
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
                            SizedBox(height: 24.h),
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
                                    final size = product.productSizes[index];
                                    final isSelected = size.id == _selectedSizeId;
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedSizeId = size.id;
                                          });
                                        },
                                        child: Container(
                                          width: 50.w,
                                          height: 50.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.primary200,
                                              width: isSelected ? 2.w : 1.w,
                                            ),
                                            color: isSelected
                                                ? AppColors.primary.withOpacity(
                                              0.1,
                                            )
                                                : AppColors.white,
                                          ),
                                          child: Text(
                                            size.title,
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
                      ),
                    ),
                    bottomNavigationBar: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      height: 105.h,
                      color: AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          GestureDetector(
                            onTap: () {
                              if (_selectedSizeId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      "Iltimos, o‘lchamni tanlang!")),
                                );
                                return;
                              }

                              context.read<CartBloc>().add(
                                CartItemAdded(
                                  productId: widget.productId,
                                  sizeId: _selectedSizeId!,
                                ),
                              );
                              // Navigatsiya BlocConsumer listenerida amalga oshiriladi
                            },
                            child: Container(
                              width: 240.w,
                              height: 54.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: _selectedSizeId != null
                                    ? AppColors.primary
                                    : AppColors.primary.withOpacity(0.6),
                              ),
                              child: isAddingToCart
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              )
                                  : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.bag,
                                    color: AppColors.white,
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  );
              }
            },
          );
        },
      ),
    );
  }
}