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
import 'package:storeapp/features/home/managers/product/product_bloc.dart';
import 'package:storeapp/features/home/managers/product/product_state.dart';
import 'package:storeapp/features/home/widgets/home_page_appbar.dart';
import '../managers/saved/saved_bloc.dart';
import '../managers/saved/saved_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(productRepo: context.read())
            ..add(ProductLoading()),
        ),
        BlocProvider(
          create: (context) => SavedBloc(repository: context.read()),
        ),
      ],
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatefulWidget {
  const _HomePageView({super.key});

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppbar(
        onCategorySelected: (categoryId) {
          context.read<ProductBloc>().add(
            ProductLoading(categoryId: categoryId == 0 ? null : categoryId),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          context.read<ProductBloc>().add(ProductLoading());
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == Status.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Xatolik yuz berdi',
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state.products.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.search,
                        width: 60.w,
                        height: 60.h,
                        color: AppColors.primary100,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Bu kategoriyada mahsulot topilmadi.',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Iltimos, boshqa kategoriyani tanlang yoki filtrni olib tashlang.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(
                      right: 24,
                      left: 24,
                      bottom: 100,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 161 / 224,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext context, index) {
                      final product = state.products[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            Routes.productDetailPage,
                            extra: product.id,
                          );
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    product.image,
                                    height: 174.h,
                                    width: 161.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: BlocBuilder<SavedBloc, SavedState>(
                                    builder: (context, savedState) {
                                      return GestureDetector(
                                        onTap: () {
                                          final savedBloc =
                                          context.read<SavedBloc>();
                                          if (product.isLiked) {
                                            savedBloc
                                                .add(UnSaveProductEvent(product));
                                          } else {
                                            savedBloc.add(SaveProductEvent(product));
                                          }
                                          setState(() {
                                            product.isLiked = !product.isLiked;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8.r),
                                            color: AppColors.white,
                                          ),
                                          alignment: Alignment.center,
                                          width: 34.w,
                                          height: 34.h,
                                          child: SvgPicture.asset(
                                            product.isLiked
                                                ? AppIcons.heartFilled
                                                : AppIcons.like,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$${product.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                    if (product.discount != 0)
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Text(
                                          "-${product.discount}%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}
