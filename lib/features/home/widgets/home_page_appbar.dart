import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/home/managers/categories/categories_bloc.dart';
import 'package:storeapp/features/home/managers/categories/categories_state.dart';
import 'package:storeapp/features/home/widgets/price_range_slider_widget.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';
import '../managers/product/product_bloc.dart';

typedef CategorySelectedCallback = void Function(int categoryId);

class HomePageAppbar extends StatefulWidget implements PreferredSizeWidget {
  final CategorySelectedCallback onCategorySelected;

  const HomePageAppbar({super.key, required this.onCategorySelected});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 126.h);

  @override
  State<HomePageAppbar> createState() => _HomePageAppbarState();
}

class _HomePageAppbarState extends State<HomePageAppbar> {
  int activInd = 0;
  double _minPrice = 0;
  double _maxPrice = 1000;
  int filterButton = 0;

  List filterItems = [
    'Relevance',
    'Price: Low - High',
    'Price: High - Low',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) => AppBar(
        title: Text(
          'Discover',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(Routes.notificationPage),
            icon: SvgPicture.asset(AppIcons.bell, width: 24.w, height: 24.h),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for clothes...',
                            prefixIcon: SvgPicture.asset(
                              AppIcons.search,
                              fit: BoxFit.scaleDown,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: AppColors.primary100,
                                width: 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 30.h),
                                    height: 405.h,
                                    child: Column(
                                      spacing: 20,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Filters',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.sp,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              borderRadius:
                                              BorderRadius.circular(12.r),
                                              onTap: () => context.pop(),
                                              child: const Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text('Sort By',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.primary)),
                                            const SizedBox(height: 12),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(
                                                  filterItems.length,
                                                      (index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setModalState(() {
                                                          filterButton = index;
                                                        });
                                                      },
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        alignment:
                                                        Alignment.center,
                                                        height: 36.h,
                                                        decoration: BoxDecoration(
                                                          color: filterButton ==
                                                              index
                                                              ? AppColors.primary
                                                              : AppColors
                                                              .transparent,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10.r),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .primary100),
                                                        ),
                                                        child: Text(
                                                          filterItems[index],
                                                          style: TextStyle(
                                                            color: filterButton ==
                                                                index
                                                                ? AppColors.white
                                                                : AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        PriceRangeSlider(
                                          onChanged: (min, max) {
                                            setModalState(() {
                                              _minPrice = min;
                                              _maxPrice = max;
                                            });
                                          },
                                        ),
                                        ButtonWidget(
                                          onTap: () {
                                            context.read<ProductBloc>().add(
                                              ProductLoading(
                                                categoryId: activInd == 0
                                                    ? null
                                                    : activInd,
                                                minPrice: _minPrice,
                                                maxPrice: _maxPrice,
                                                orderBy: filterButton,
                                              ),
                                            );
                                            context.pop();
                                          },
                                          text: 'Apply Filters',
                                          buttonColor: AppColors.primary,
                                          textColor: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 52.w,
                          height: 52.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.primary,
                          ),
                          child: SvgPicture.asset(
                            AppIcons.filter,
                            width: 24.w,
                            height: 24.h,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton(context, 0, "All"),
                      ...List.generate(state.categories.length, (index) {
                        final category = state.categories[index];
                        return _buildCategoryButton(
                            context, category.id, category.title);
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, int id, String title) {
    return GestureDetector(
      onTap: () {
        setState(() => activInd = id);
        widget.onCategorySelected(id);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        height: 36.h,
        decoration: BoxDecoration(
          color: activInd == id
              ? AppColors.primary
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primary100),
        ),
        child: Text(
          title,
          style: TextStyle(
            color:
            activInd == id ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
