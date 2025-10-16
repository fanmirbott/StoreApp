import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/core/dependencies.dart';
import 'package:storeapp/core/routing/router.dart';

import 'core/utils/secure_storege.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await AuthStorage.getToken();
  print('Main token: $token');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final tokenPhone = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.requestPermission();
  print('telefon token🛑: $tokenPhone');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviderMain,
      child: MultiBlocProvider(
        providers: providerBloc,
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
