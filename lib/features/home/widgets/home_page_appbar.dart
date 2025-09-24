import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/data/repositories/products/categories_repository.dart';
import 'package:storeapp/features/home/managers/categories_view_model.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';

class HomePageAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HomePageAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 126.h);
  @override
  State<HomePageAppbar> createState() => _HomePageAppbarState();
}

class _HomePageAppbarState extends State<HomePageAppbar> {
  int activInd = 0;

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
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 24
                    ),
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
                          onTap: (){},
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
                        ...List.generate(vm.categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              activInd = index;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              height: 36.h,
                              decoration: BoxDecoration(
                                color: activInd == index
                                    ? AppColors.primary
                                    : AppColors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: AppColors.primary100),
                              ),
                              child: Text(
                                vm.categories[index].title,
                                style: TextStyle(
                                  color: activInd == index
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
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
