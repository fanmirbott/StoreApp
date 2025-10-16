import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  final MapController _mapController = MapController();
  final LatLng _origin = const LatLng(41.3111, 69.2797);
  final LatLng _destination = const LatLng(41.2980, 69.2450);
  final LatLng _truckLocation = const LatLng(41.3050, 69.2600);

  List<Marker> _markers = [];
  List<Polyline> _polylines = [];

  final List<Map<String, dynamic>> orderSteps = const [
    {'status': 'Packing', 'address': '2336 Jack Warren Rd, Delta Junction, Alaska...', 'is_active': false},
    {'status': 'Picked', 'address': '2417 Tongass Ave #111, Ketchikan, Alaska 9...', 'is_active': false},
    {'status': 'In Transit', 'address': '16 Rr 2, Ketchikan, Alaska 99901, USA', 'is_active': true},
    {'status': 'Delivered', 'address': '925 S Chugach St #APT 10, Alaska 99645', 'is_active': false},
  ];

  @override
  void initState() {
    super.initState();
    _initializeMapData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOrderTrackingSheet(context);
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _initializeMapData() {
    _polylines = [
      Polyline(
        points: [_origin, const LatLng(41.3100, 69.2700), _truckLocation, const LatLng(41.3000, 69.2550), _destination],
        strokeWidth: 4.0,
        color: AppColors.primary,
        useStrokeWidthInMeter: false,
      ),
    ];

    _markers = [
      Marker(
        point: _truckLocation,
        width: 50.w,
        height: 50.h,
        child: Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          child: const Icon(Icons.local_shipping, color: AppColors.primary, size: 20),
        ),
      ),
      Marker(
        point: _origin,
        width: 30.w,
        height: 30.h,
        child: const Icon(Icons.radio_button_checked, color: AppColors.primary, size: 30),
      ),
      Marker(
        point: _destination,
        width: 30.w,
        height: 30.h,
        child: const Icon(Icons.location_on, color: AppColors.primary, size: 30),
      ),
    ];
  }

  void _showOrderTrackingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.5.w,
            right: 24.5.w,
            top: 20.h,
            bottom: MediaQuery.of(context).padding.bottom + 10.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Order Status',
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
                    child: const Icon(Icons.close, size: 24, color: AppColors.primary500),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 250.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderSteps.length,
                  itemBuilder: (context, index) {
                    final step = orderSteps[index];
                    final isActive = step['is_active'] as bool;
                    final isPast = index < 2;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              margin: EdgeInsets.only(top: 5.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isPast || isActive ? AppColors.primary : AppColors.primary500,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            if (index < orderSteps.length - 1)
                              Container(
                                width: 2.w,
                                height: 50.h,
                                color: isPast || isActive ? AppColors.primary : AppColors.primary500,
                              ),
                          ],
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step['status']!,
                                  style: TextStyle(
                                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                                    fontSize: isActive ? 16.sp : 14.sp,
                                    color: isPast || isActive ? AppColors.primary : AppColors.primary500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  step['address']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: AppColors.primary500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 10.h),
              const Divider(),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: Image.asset(
                          'assets/images/jacob_jones.png',
                          width: 48.r,
                          height: 48.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 48.r,
                            height: 48.r,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary100),
                            child: const Icon(Icons.person, color: AppColors.primary),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jacob Jones',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'Delivery Guy',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.primary500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: () {
                    },
                    borderRadius: BorderRadius.circular(24.r),
                    child: Container(
                      width: 48.r,
                      height: 48.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: const Icon(Icons.call, color: AppColors.white, size: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(text: 'Track Order'),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _truckLocation,
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "track_order_page",
                ),
                PolylineLayer(
                  polylines: _polylines,
                ),
                MarkerLayer(
                  markers: _markers,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}