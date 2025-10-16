import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../../../core/utils/status.dart';
import '../../common/widgets/bottom_navigation_bar_app.dart';
import '../managers/savedBloc/saved_bloc.dart';
import '../managers/savedBloc/saved_state.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedProductsBloc>().add(FetchSavedProducts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(text: 'Saved Items'),
      body: BlocBuilder<SavedProductsBloc, SavedProductsState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == Status.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Xatolik yuz berdi'),
            );
          }

          if (state.savedProducts.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 230.h, left: 69.w, right: 69.w),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppIcons.heartDuotone,
                    width: 64.w,
                    height: 64.h,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'No Saved Items!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    textAlign: TextAlign.center,
                    'You don’t have any saved items. Go to home and add some.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.primary500,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: ()async {
              context.read<SavedProductsBloc>().add(FetchSavedProducts());
            },
            child: GridView.builder(
              padding: const EdgeInsets.only(right: 24, left: 24, bottom: 60),
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
                                final bloc = context.read<SavedProductsBloc>();
                                if (product.isLiked) {
                                  bloc.add(UnSaveProductEvent(product.id));
                                } else {
                                  bloc.add(SaveProductEvent(product.id));
                                }
                                setState(() {
                                  
                                });
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
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}
