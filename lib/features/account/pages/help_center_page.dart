import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/features/account/widgets/help_center_button.dart';
import 'package:storeapp/features/home/widgets/bottom_navigation_bar_app.dart';

import '../../../core/utils/icons.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  List icons = [
    AppIcons.headphones,
    AppIcons.whatsapp,
    AppIcons.web,
    AppIcons.facebook,
    AppIcons.twitter,
    AppIcons.instagram
  ];
  List textItems = [
    'Customer Service',
    'Whatsapp',
    'Website',
    'Facebook',
    'Twitter',
    'Instagram'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppIcons.backArrow),
        ),
        centerTitle: true,
        title: const Text(
          'Help Center',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.bell),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(right: 24, left: 24, top: 24),
        child: Column(
          spacing: 14,
          children: [
            ...List.generate(icons.length, (index){
              return HelpCenterButton(icon: icons[index], text: textItems[index], onTap: () {  },);
            })
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
    );
  }
}
