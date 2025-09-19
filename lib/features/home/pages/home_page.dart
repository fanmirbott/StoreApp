import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/data/repositories/product_repository.dart';
import 'package:storeapp/features/home/managers/product_view_model.dart';
import 'package:storeapp/features/home/widgets/home_page_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> bottomNavItems = [
    {"icon": AppIcons.home, "page": HomePage()},
    {"icon": AppIcons.search, "page": SearchPage()},
    {"icon": AppIcons.heart, "page": FavoritesPage()},
    {"icon": AppIcons.cart, "page": CartPage()},
    {"icon": AppIcons.user, "page": ProfilePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppbar(),
      body: ChangeNotifierProvider(
        create: (context) => ProductViewModel(
          repository: ProductRepository(client: ApiClient())..getProducts(),
        )..getProducts(),
        builder: (context, child) => Consumer<ProductViewModel>(
          builder: (context, vm, child) => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 161 / 224,
                  ),
                  itemCount: vm.products.length,
                  itemBuilder: (BuildContext context, index) {
                    final product = vm.products[index];
                    return Column(
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
                                  setState(() {
                                    isLike = !isLike;
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
                                    isLike
                                        ? AppIcons.heartFilled
                                        : AppIcons.like,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                  "\$ ${product.price} ${product.discount}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: AppColors.primary500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 86,
        decoration: BoxDecoration(color: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(bottomNavItems.length, (index) {
            final item = bottomNavItems[index];
            final isSelected = currentIndex == index;

            return InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item["page"]),
                );
              },
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary100 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  item["icon"],
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primary : AppColors.primary500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
