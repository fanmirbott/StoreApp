import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_bloc.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_state.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';

import '../../../core/routing/routes.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressBloc(context.read(), addressRepo: context.read()),
      child: Scaffold(
        appBar: AppBarWidgets(text: 'Address'),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            final data = state.address;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  right: 24.w,
                  left: 24.w,
                  bottom: 40.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 14,
                  children: [
                    Divider(),
                    Text(
                      'Saved Address',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    ...List.generate(state.address.length, (index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          width: 341.w,
                          height: 76.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primary100),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.location,
                                width: 24.w,
                                height: 24.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index].title,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    data[index].fullAddress,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primary500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    GestureDetector(
                      onTap: () {
                        context.push(Routes.newAddressPage);
                      },
                      child: Container(
                        margin: EdgeInsetsGeometry.only(top: 10),
                        width: 341.w,
                        height: 54.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppIcons.plus,
                              width: 24.w,
                              height: 24.h,
                            ),
                            Text(
                              'Add New Address',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 70.h,),
                    ButtonWidget(
                      onTap: () {},
                      width: 341.w,
                      text: 'Apply',
                      buttonColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
