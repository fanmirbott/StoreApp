import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_bloc.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_state.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import '../../../core/routing/routes.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int? selectedDefaultId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AddressBloc(addressRepo: context.read())..add(AddressLoading()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidgets(text: 'Address'),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            final addresses = state.address;

            if (addresses.isNotEmpty && selectedDefaultId == null) {
              final defaultAddress = addresses.firstWhere(
                    (a) => a.isDefault,
                orElse: () => addresses.first,
              );
              selectedDefaultId = defaultAddress.id;
            }

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<AddressBloc>().add(AddressLoading());
                    },
                    child: ListView(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      children: [
                        Text(
                          'Saved Address',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ...addresses.map((address) {
                          return GestureDetector(
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r),
                                  ),
                                ),
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.all(20.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 50.w,
                                          height: 5.h,
                                          margin:
                                          EdgeInsets.only(bottom: 16.h),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        Text(
                                          "Manage Address",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        ListTile(
                                          leading: const Icon(Icons.delete,
                                              color: Colors.red),
                                          title: const Text(
                                            'Delete',
                                            style:
                                            TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            context
                                                .read<AddressBloc>()
                                                .add(AddressDelete(address.id!));
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          leading: const Icon(Icons.close),
                                          title: const Text('Cancel'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedDefaultId == address.id
                                      ? AppColors.primary
                                      : AppColors.primary100,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.05),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primary,
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      address.nickname,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    if (address.isDefault)
                                      Container(
                                        margin: EdgeInsets.only(left: 6.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary100,
                                          borderRadius:
                                          BorderRadius.circular(6.r),
                                        ),
                                        child: Text(
                                          'Default',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Text(
                                    address.fullAddress,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.primary500,
                                    ),
                                  ),
                                ),
                                trailing: Radio<int>(
                                  value: address.id!,
                                  groupValue: selectedDefaultId,
                                  activeColor: AppColors.primary,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDefaultId = value;
                                    });
                                    final updatedList = addresses.map((a) {
                                      if (a.id == address.id) {
                                        return a.copyWith(isDefault: true);
                                      } else {
                                        return a.copyWith(isDefault: false);
                                      }
                                    }).toList();
                                    context
                                        .read<AddressBloc>()
                                        .add(AddressLoading());

                                  },
                                ),
                              ),
                            ),
                          );
                        }).toList(),

                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () => context.push(Routes.newAddressPage),
                          child: Container(
                            height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.primary100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.plus, width: 20.w),
                                SizedBox(width: 8.w),
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
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
