import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/features/home/managers/savedProduct/saved_bloc.dart';
import 'package:storeapp/features/home/managers/savedProduct/saved_state.dart';

import '../../../core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../../home/widgets/bottom_navigation_bar_app.dart';

class SavedItemsPage extends StatelessWidget {
  const SavedItemsPage({super.key});
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
          'Saved Items',
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
      body: BlocBuilder<SavedProductsBloc, SavedProductsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(right: 24, left: 24, bottom: 100),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 161 / 224,
                  ),
                  itemCount: state.savedProducts.length,
                  itemBuilder: (BuildContext context, index) {
                    final product = state.savedProducts[index];
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
                                child: GestureDetector(
                                  onTap: () {
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
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
      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}
