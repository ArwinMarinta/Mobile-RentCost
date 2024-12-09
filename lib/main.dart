import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/Authentication/ChangePassword/bloc/change_password_bloc.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/forgot_password_bloc.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/verify_email_bloc.dart';
import 'package:rentcost/features/Authentication/Register/bloc/register_bloc.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_bloc.dart';
import 'package:rentcost/features/address/bloc/address_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_bloc.dart';
import 'package:rentcost/features/cart/bloc/cart_bloc.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/product/bloc/detail_bloc.dart';
import 'package:rentcost/features/product/bloc/product_bloc.dart';
import 'package:rentcost/features/product/bloc/search_bloc.dart';
import 'package:rentcost/features/stores/bloc/stores_bloc.dart';
import 'package:rentcost/features/users/bloc/user_bloc.dart';
import 'package:rentcost/features/users/bloc/user_product_bloc.dart';

import 'package:rentcost/routes/app.routes.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(
          create: (context) => UserBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => BannerBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => StoreBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddressBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => DetailBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductUserBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => SplashBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => ChangePasswordBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => CartBloc(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => VerifyEmailBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RentCost',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerConfig: goRouter(),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('State Change: $change');
  }
}
