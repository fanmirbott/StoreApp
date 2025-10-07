import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/features/common/widgets/bottom_navigation_bar_app.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  Map<String, bool> notificationSettings = {
    'General Notifications': true,
    'Sound': true,
    'Vibrate': false,
    'Special Offers': true,
    'Promo & Discounts': false,
    'Payments': false,
    'Cashback': true,
    'App Updates': false,
    'New Service Available': false,
    'New Tips Available': false,
  };

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 24.w);

    return Scaffold(
      appBar: AppBarWidgets(text: 'Notifications'),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              ...notificationSettings.keys.map((title) {
                return Column(
                  children: [
                    Divider(
                      color: AppColors.primary100,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 62.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                              Switch(
                                value: notificationSettings[title]!,
                                activeColor: AppColors.white,
                                activeTrackColor: AppColors.primary,
                                onChanged: (newValue) {
                                  setState(() {
                                    notificationSettings[title] = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
