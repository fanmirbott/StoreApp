import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/core/routing/router.dart';
import 'package:storeapp/data/repositories/notification_repository.dart';
import 'package:storeapp/data/repositories/products/cart_repository.dart';
import 'package:storeapp/data/repositories/products/product_detail_repository.dart';
import 'package:storeapp/data/repositories/saved_repository.dart';
import 'core/client.dart';
import 'data/repositories/products/product_repository.dart';
import 'features/home/managers/cart/cart_bloc.dart';
import 'features/home/managers/savedProduct/saved_bloc.dart';
import 'features/home/managers/saved_view_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final token = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.requestPermission();
  print('telefon token🛑: ${token}');
  runApp( MyApp());
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
        RepositoryProvider(
          create: (context) => CartRepository(client: context.read()),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(client: context.read()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartBloc(
              cartRepository: context.read<CartRepository>(),
            )..add(CartLoading()),
          ),
          BlocProvider(
            create: (context) => SavedProductsBloc(
              savedRepo: context.read<ProductRepository>(),
            )..add(FetchSavedProducts()),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => SavedViewModel(
                repository: context.read<SavedRepository>(),
              ),
            ),
          ],
          child: ScreenUtilInit(
            designSize: Size(390, 844),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}
