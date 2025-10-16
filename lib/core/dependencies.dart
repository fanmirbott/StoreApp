import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:storeapp/core/client.dart';
import 'package:storeapp/data/repositories/address_repository.dart';
import 'package:storeapp/data/repositories/auth/auth_repository.dart';
import 'package:storeapp/data/repositories/auth/user_repository.dart';
import 'package:storeapp/data/repositories/card_repository.dart';
import 'package:storeapp/data/repositories/cart_repository.dart';
import 'package:storeapp/data/repositories/categories_repository.dart';
import 'package:storeapp/data/repositories/notification_repository.dart';
import 'package:storeapp/data/repositories/orders_repository.dart';
import 'package:storeapp/data/repositories/product_detail_repository.dart';
import 'package:storeapp/data/repositories/product_repository.dart';
import 'package:storeapp/data/repositories/saved_repository.dart';
import 'package:storeapp/features/Card/managers/cards/card_bloc.dart';
import 'package:storeapp/features/account/managers/addressBloc/address_bloc.dart';
import 'package:storeapp/features/account/managers/chatBloc/chat_bloc.dart';
import 'package:storeapp/features/account/managers/ordersBloc/orders_bloc.dart';
import 'package:storeapp/features/account/managers/updateUserBloc/update_user_bloc.dart';
import 'package:storeapp/features/account/managers/userBloc/user_bloc.dart';
import 'package:storeapp/features/auth/managers/authBloc/auth_bloc.dart';
import 'package:storeapp/features/cartPage/managers/cart/cart_bloc.dart';
import 'package:storeapp/features/home/managers/categories/categories_bloc.dart';
import 'package:storeapp/features/saved/managers/savedBloc/saved_bloc.dart';
import '../features/home/managers/product/product_bloc.dart';

final repositoryProviderMain = <SingleChildWidget>[
  RepositoryProvider(create: (_) => ApiClient()),
  RepositoryProvider(
    create: (context) =>
        AuthRepository(client: context.read<ApiClient>()),
  ),
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
  RepositoryProvider(
    create: (context) => CardRepository(client: context.read()),
  ),
  RepositoryProvider(
    create: (context) =>
        UserRepository(client: context.read<ApiClient>()),
  ),
  RepositoryProvider(
    create: (context) => AddressRepository(client: context.read()),
  ),
  RepositoryProvider<CategoryRepository>(
    create: (context) => CategoryRepository(
      client: context.read<ApiClient>(),
    ),
  ),
  RepositoryProvider<OrdersRepository>(
    create: (context) => OrdersRepository(
      client: context.read(),
    ),
  ),
];
final providerBloc = <SingleChildWidget>[
  BlocProvider(
    create: (context) =>
        AuthBloc(repository: context.read<AuthRepository>()),
  ),
  BlocProvider(
    create: (context) => CartBloc(
      cartRepository: context.read<CartRepository>(),
    )..add(CartLoading()),
  ),
  BlocProvider(
    create: (context) => SavedProductsBloc(
      repository: context.read<ProductRepository>(),
    )..add(FetchSavedProducts()),
  ),
  BlocProvider(
    create: (context) => CardBloc(
      cardRepo: context.read<CardRepository>(),
    ),
  ),
  BlocProvider(
    create: (context) => UserBloc(
      userRepository: context.read<UserRepository>(),
    )..add(FetchUser()),
  ),
  BlocProvider(
    create: (context) => UpdateUserBloc(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  BlocProvider(
    create: (context) => AddressBloc(
      addressRepo: context.read<AddressRepository>(),
    ),
  ),
  BlocProvider(
    create: (context) => ChatBloc(),
  ),
  BlocProvider(
    create: (context) => CategoriesBloc(
      categoriesRepo: context.read<CategoryRepository>(),
    )..add(CategoriesLoading()),
  ),
  BlocProvider(
    create: (context) => ProductBloc(
      productRepo: context.read<ProductRepository>(),
    ),
  ),
  BlocProvider(
    create: (context) =>
    OrdersBloc(
      ordersRepo: context.read<OrdersRepository>(),
    )..add(
      OrdersGet(),
    ),
  ),
];
