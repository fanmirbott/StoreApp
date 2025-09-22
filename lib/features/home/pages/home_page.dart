import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/data/repositories/products/product_repository.dart';
import 'package:storeapp/features/home/managers/product_view_model.dart';
import 'package:storeapp/features/home/widgets/bottom_navigation_bar_app.dart';
import 'package:storeapp/features/home/widgets/home_page_appbar.dart';

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
                  padding: const EdgeInsets.only(right: 24, left: 24, bottom: 100),
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
                      onTap: (){
                        context.push(Routes.productDetailPage);
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
                          SizedBox(height: 8,),
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
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar:BottomNavigationBarApp()
    );
  }
}
