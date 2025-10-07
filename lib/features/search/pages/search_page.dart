import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:storeapp/features/home/managers/product_view_model.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.length >= 2 || query.isEmpty) {
      context.read<ProductViewModel>().getProducts(title: query.isEmpty ? null : query);
    }
  }

  Widget _buildProductList(ProductViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.products.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w),
          child: Text(
            '"${_searchController.text}" so‘rovi bo‘yicha mahsulot topilmadi.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
          ),
        ),
      );
    }

    if (vm.products.isEmpty && _searchController.text.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Recent Searches',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: (){
                },
                child: Text(
                  'Clear all',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          _buildRecentSearchItem(context, 'Jeans'),
          _buildRecentSearchItem(context, 'Casual clothes'),
          _buildRecentSearchItem(context, 'Hoodie'),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vm.products.length,
      itemBuilder: (context, index) {
        final product = vm.products[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: GestureDetector(
            onTap: () {
              context.push(
                Routes.productDetailPage,
                extra: product.id,
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    product.image,
                    height: 60.h,
                    width: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary500),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentSearchItem(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {
            },
            child: const Icon(Icons.close, size: 20, color: AppColors.primary500),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcons.bell)),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, vm, child) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            borderRadius: BorderRadius.circular(40.r),
                            onTap: () {
                              _searchController.clear();
                            },
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
                  ],
                ),
                SizedBox(height: 24.h),
                _buildProductList(vm),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
