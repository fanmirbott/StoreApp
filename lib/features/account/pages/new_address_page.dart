import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:storeapp/core/routing/routes.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/data/models/address_model.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_bloc.dart';
import 'package:storeapp/core/utils/status.dart';
import '../managers/addressBloc/address_state.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage>
    with TickerProviderStateMixin {
  final controller = MapController();
  final controllerAddressNickname = TextEditingController();
  final controllerFullAddress = TextEditingController();

  bool isDefault = false;
  LatLng? selectedPoint;
  List<Marker> markers = [];

  @override
  void dispose() {
    controllerAddressNickname.dispose();
    controllerFullAddress.dispose();
    controller.dispose();
    super.dispose();
  }

  void _openBottomSheet(LatLng point) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24.5.w,
                right: 24.5.w,
                top: 30.h,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 20.h,
              ),
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => context.pop(),
                        child: const Icon(Icons.close, size: 24),
                      ),
                    ],
                  ),
                  const Divider(),
                  TextFieldAndText(
                    controller: controllerAddressNickname,
                    text: 'Address Nickname',
                    hintText: 'Choose one',
                    onChanged: (_) => setModalState(() {}),
                  ),
                  TextFieldAndText(
                    controller: controllerFullAddress,
                    text: 'Full Address',
                    hintText: 'Enter your full address...',
                    onChanged: (_) => setModalState(() {}),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isDefault,
                        onChanged: (value) {
                          setModalState(() {
                            isDefault = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'Make this as a default address',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<AddressBloc, AddressState>(
                    listener: (context, state) {
                      if (state.createStatus == Status.success) {
                        context.pop();
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                content: SizedBox(
                                  width: 341.w,
                                  height: 270.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.checkDoutone,
                                        width: 78.w,
                                        height: 78.h,
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Text(
                                        'Congratulations!',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Your new address has been added.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.primary500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      ButtonWidget(
                                        width: 293.w,
                                        onTap: () {
                                          context.pop();
                                        },
                                        text: 'Thanks',
                                        buttonColor: AppColors.primary,
                                        textColor: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state.createStatus == Status.loading;
                      final isButtonActive =
                          controllerAddressNickname.text.isNotEmpty &&
                              controllerFullAddress.text.isNotEmpty;

                      return ButtonWidget(
                        onTap: () {
                          final newAddress = AddressModel(
                            nickname: controllerAddressNickname.text,
                            fullAddress: controllerFullAddress.text,
                            isDefault: isDefault,
                            lat: point.latitude,
                            lng: point.longitude,
                          );

                          context.read<AddressBloc>().add(
                            AddressPost(newAddress),
                          );
                        },
                        text: isLoading ? 'Adding...' : 'Add',
                        width: 341.w,
                        buttonColor: isButtonActive
                            ? AppColors.primary
                            : AppColors.primary400,
                        textColor: AppColors.white,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(text: 'New Address'),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 742.h,
            child: FlutterMap(
              mapController: controller,
              options: MapOptions(
                initialCenter: LatLng(41.285779, 69.203493),
                initialZoom: 15,
                onTap: (tapPosition, point) {
                  setState(() {
                    markers = [
                      Marker(
                        point: point,
                        child: SvgPicture.asset(AppIcons.locationDuotone),
                      ),
                    ];
                    selectedPoint = point;
                  });
                  _openBottomSheet(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "new_address_page",
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
