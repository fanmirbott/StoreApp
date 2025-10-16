import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/status.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/data/models/product_model.dart';
import 'package:storeapp/features/home/managers/review/review_bloc.dart';
import 'package:storeapp/features/home/managers/review/review_state.dart';
import 'package:storeapp/features/home/managers/saved/saved_bloc.dart';
import '../../../data/models/review_model.dart';
import '../../../data/repositories/review_repository.dart';
import '../../cartPage/managers/cart/cart_bloc.dart';
import '../../home/managers/productDetail/product_detail_bloc.dart';
import '../../home/managers/productDetail/product_detail_state.dart';
import '../managers/review/review_events.dart';

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
        BlocProvider(
          create: (context) => ReviewBloc(
            ReviewRepository(apiClient: context.read<ApiClient>()),
          )..add(FetchReviews(widget.productId)),
        ),
      ],
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, cartState) {
          if (cartState.status == Status.success &&
              cartState.lastAddedItem != null) {
            context.push(Routes.cartPage);
          }
        },
        builder: (context, cartState) {
          final isAddingToCart =
              cartState.status == Status.loading &&
              cartState.lastAddedItem == null;

          return BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.initial:
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
                            Stack(
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
                                Positioned(
                                  top: 16.h,
                                  right: 16.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      final savedBloc = context
                                          .read<SavedBloc>();
                                      if (product.isLiked) {
                                        savedBloc.add(
                                          UnSaveProductEvent(product as ProductModel),
                                        );
                                      } else {
                                        savedBloc.add(
                                          SaveProductEvent(product as ProductModel),
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        color: AppColors.white,
                                      ),
                                      alignment: Alignment.center,
                                      width: 48.w,
                                      height: 48.h,
                                      child: SvgPicture.asset(
                                        width: 25.w,
                                        height: 25.h,
                                        product.isLiked
                                            ? AppIcons.heartFilled
                                            : AppIcons.like,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                    final isSelected =
                                        size.id == _selectedSizeId;
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

                            SizedBox(height: 32.h),
                            const Divider(),
                            SizedBox(height: 12.h),
                            Text(
                              "Reviews",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            BlocBuilder<ReviewBloc, ReviewState>(
                              builder: (context, state) {
                                if (state is ReviewInitial ||
                                    state is ReviewLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is ReviewLoaded) {
                                  if (state.reviews.isEmpty) {
                                    return const Text("Hozircha sharh yo‘q.");
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.reviews.length,
                                    itemBuilder: (context, i) =>
                                        _buildSingleReview(
                                          context,
                                          state.reviews[i],
                                        ),
                                  );
                                } else if (state is ReviewError) {
                                  return Text("Xatolik: ${state.message}");
                                }
                                return const SizedBox.shrink();
                              },
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
                                  const SnackBar(
                                    content: Text(
                                      "Iltimos, o‘lchamni tanlang!",
                                    ),
                                  ),
                                );
                                return;
                              }
                              context.read<CartBloc>().add(
                                CartItemAdded(
                                  productId: widget.productId,
                                  sizeId: _selectedSizeId!,
                                ),
                              );
                              context.push(Routes.cartPage);
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
                                          colorFilter: ColorFilter.mode(
                                            AppColors.white,
                                            BlendMode.srcIn,
                                          ),
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

  Widget _buildSingleReview(BuildContext context, ReviewModel review) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (i) {
              return Icon(
                Icons.star,
                color: i < review.rating.round()
                    ? Colors.orange
                    : (isDark ? Colors.grey[600] : Colors.grey[300]),
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(review.comment),
        ],
      ),
    );
  }
}
