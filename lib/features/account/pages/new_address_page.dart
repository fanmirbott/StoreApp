import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';

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
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            bool isButtonActive = controllerAddressNickname.text.isNotEmpty &&
                controllerFullAddress.text.isNotEmpty;

            void updateState() => setModalState(() {});

            controllerAddressNickname.addListener(updateState);
            controllerFullAddress.addListener(updateState);

            return Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 24.5.w, vertical: 30.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
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
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.close, size: 24),
                      ),
                    ],
                  ),
                  Divider(),
                  TextFieldAndText(
                    controller: controllerAddressNickname,
                    text: 'Address Nickname',
                    hintText: 'Choose one',
                  ),
                  TextFieldAndText(
                    controller: controllerFullAddress,
                    text: 'Full Address',
                    hintText: 'Enter your full address...',
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isDefault,
                        onChanged: (value) {
                          setModalState(() {
                            isDefault = value!;
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
                  ButtonWidget(
                    onTap: ()=> isButtonActive
                        ? () {
                      context.pop();
                    }
                        : null,
                    width: 341.w,
                    text: 'Add',
                    buttonColor: isButtonActive
                        ? Colors.black
                        : AppColors.primary400,
                    textColor: AppColors.white,
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
                  final animationController = AnimationController(
                    vsync: this,
                    duration: Duration(milliseconds: 500),
                  );

                  final marker = Marker(
                    point: point,
                    child: SvgPicture.asset(AppIcons.locationDuotone),
                  );
                  markers.add(marker);

                  final tween = LatLngTween(
                    begin: controller.camera.center,
                    end: point,
                  );
                  final animation = tween.animate(animationController);
                  animation.addListener(() {
                    controller.move(animation.value, controller.camera.zoom);
                  });
                  animationController.forward();
                  animation.addStatusListener((status) {
                    if (status == AnimationStatus.completed) {
                      animationController.dispose();
                    }
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
