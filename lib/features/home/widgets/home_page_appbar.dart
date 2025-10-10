import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/data/repositories/categories_repository.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/home/managers/categories_view_model.dart';
import 'package:storeapp/features/home/widgets/price_range_slider_widget.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';

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

  List filterItems = [
    'Relevance',
    'Price: Low - High',
    'Price: High - Low',
  ];

  int filterButton = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoriesViewModel(
        repository: CategoryRepository(client: ApiClient())..getCategories(),
      )..getCategories(),
      builder: (context, child) => Consumer<CategoriesViewModel>(
        builder: (context, vm, child) => AppBar(
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
              onPressed: () {
                context.push(Routes.notificationPage);
              },
              icon: SvgPicture.asset(
                AppIcons.bell,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                    child: Row(
                      spacing: 14,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              borderRadius: BorderRadius.circular(40.r),
                              onTap: () {},
                              child: SvgPicture.asset(
                                AppIcons.mic,
                                width: 24.w,
                                height: 24.h,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            prefixIcon: SvgPicture.asset(
                              AppIcons.search,
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.scaleDown,
                            ),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.primary200,
                            ),
                            hintText: 'Search for clothes...',
                            constraints: BoxConstraints(
                              maxHeight: 52.h,
                              maxWidth: 281.w,
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
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24.5,
                                        vertical: 30,
                                      ),
                                      width: double.infinity,
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
                                                onTap: () {
                                                  context.pop();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Sort By',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: List.generate(
                                                    filterItems.length,
                                                    (index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setModalState(() {
                                                            filterButton =
                                                                index;
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color:
                                                                filterButton ==
                                                                    index
                                                                ? AppColors
                                                                      .primary
                                                                : AppColors
                                                                      .transparent,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10.r,
                                                                ),
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .primary100,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 20,
                                                              ),
                                                          height: 36.h,
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets.only(
                                                                right: 8,
                                                              ),
                                                          child: Text(
                                                            filterItems[index],
                                                            style: TextStyle(
                                                              color:
                                                                  filterButton ==
                                                                      index
                                                                  ? AppColors
                                                                        .white
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
                                          Divider(),
                                          PriceRangeSlider(),
                                          ButtonWidget(
                                            onTap: () {},
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
                            child: SvgPicture.asset(AppIcons.filter),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 8,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              activInd = 0;
                            });
                            widget.onCategorySelected(0);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: activInd == 0
                                  ? AppColors.primary
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColors.primary100),
                            ),
                            child: Text(
                              "All",
                              style: TextStyle(
                                color: activInd == 0
                                    ? AppColors.white
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(vm.categories.length, (index) {
                          final category = vm.categories[index];
                          final categoryId = category.id;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activInd = categoryId;
                              });
                              widget.onCategorySelected(categoryId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              height: 36.h,
                              decoration: BoxDecoration(
                                color: activInd == categoryId
                                    ? AppColors.primary
                                    : AppColors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: AppColors.primary100),
                              ),
                              child: Text(
                                category.title,
                                style: TextStyle(
                                  color: activInd == categoryId
                                      ? AppColors.white
                                      : AppColors.primary,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
