import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/core/routing/router.dart';
import 'package:storeapp/data/repositories/notification_repository.dart';
import 'package:storeapp/data/repositories/products/product_detail_repository.dart';
import 'package:storeapp/data/repositories/saved_repository.dart';

import 'core/client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiClient()),
        RepositoryProvider(
          create: (context) => NotificationRepository(client: context.read()),
        ),
        RepositoryProvider(
          create: (context) => ProductDetailRepository(client: context.read()),
        ),
        RepositoryProvider(
          create: (context) => SavedRepository(client: context.read()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(390, 844),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
