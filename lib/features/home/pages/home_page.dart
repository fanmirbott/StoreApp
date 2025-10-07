import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/home/managers/product_view_model.dart';
import 'package:storeapp/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:storeapp/features/home/widgets/home_page_appbar.dart';

import '../managers/saved_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppbar(
        onCategorySelected: (categoryId) {
          context.read<ProductViewModel>().getProducts(
            categoryId: categoryId == 0 ? null : categoryId,
          );
        },
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Text(
                'Xatolik: ${vm.errorMessage}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (vm.products.isEmpty) {
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
                  itemCount: vm.products.length,
                  itemBuilder: (BuildContext context, index) {
                    final product = vm.products[index];
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
                                child: Consumer<SavedViewModel>(
                                  builder: (context, savedVm, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (product.isLiked) {
                                          savedVm.unSaveProduct(
                                            product,
                                            context,
                                          );
                                        } else {
                                          savedVm.saveProduct(product, context);
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
                          SizedBox(
                            height: 8,
                          ),
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
      extendBody: true,
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}