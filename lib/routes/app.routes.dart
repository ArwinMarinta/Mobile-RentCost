import 'package:flutter/material.dart';
import 'package:rentcost/features/Authentication/Register/bloc/register_bloc.dart';
import 'package:rentcost/features/SplashScreen/view/splash.dart';
import 'package:rentcost/features/stores/view/create_store.dart';
import 'package:rentcost/features/address/view/add_address.dart';
import 'package:rentcost/features/stores/view/detail_product.dart';
import 'package:rentcost/features/stores/view/add_costum.dart';
import 'package:rentcost/features/stores/view/update_costum.dart';
import 'package:rentcost/features/cart/view/cart.dart';
import 'package:rentcost/features/category/view/category.dart';
import 'package:rentcost/features/Authentication/ChangePassword/view/change_password.dart';
import 'package:rentcost/features/view/confirm_payment.dart';
import 'package:rentcost/features/banner/view/create_banner.dart';
import 'package:rentcost/features/category/view/create_category.dart';
import 'package:rentcost/features/product/view/detail_costum.dart';
import 'package:rentcost/features/view/detail_history.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/view/forgot_password.dart';
import 'package:rentcost/features/view/history_tenant.dart';
import 'package:rentcost/features/home/home.dart';
import 'package:rentcost/features/Authentication/Login/view/login.dart';
import 'package:rentcost/features/view/my_order.dart';
import 'package:rentcost/features/stores/view/my_rental.dart';
import 'package:rentcost/features/view/payment.dart';
import 'package:rentcost/features/users/view/personal.dart';
import 'package:rentcost/features/view/profile.dart';
import 'package:rentcost/features/Authentication/Register/view/register.dart';
import 'package:rentcost/features/product/view/search.dart';
import 'package:rentcost/features/address/view/select_address.dart';
import 'package:rentcost/features/stores/view/shop.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/view/verify_email.dart';
import 'package:rentcost/features/banner/view/banner.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rentcost/routes/navigation_bloc.dart';

// import 'package:RentCost/features/view/shopping.dart';
import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: "/splash", routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: Home());
      },
    ),
    GoRoute(
        path: "/shop",
        pageBuilder: (context, state) => const NoTransitionPage(child: Shop())),
    GoRoute(
      path: "/category",
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: Category());
      },
    ),
    GoRoute(
        path: "/profile",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Profile())),
    GoRoute(
        path: "/search",
        pageBuilder: (context, state) => NoTransitionPage(child: Search())),
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: LoginPage());
      },
    ),
    GoRoute(
      path: "/personal",
      pageBuilder: (context, state) {
        return NoTransitionPage(child: Personal());
      },
    ),
    GoRoute(
      path: "/register",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: Register()),
    ),
    GoRoute(
        path: "/cart",
        pageBuilder: (context, state) => const NoTransitionPage(child: Cart())),
    GoRoute(
        path: "/verify-email",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: VerifyEmail())),
    GoRoute(
        path: "/select_address",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SelectAddress())),
    GoRoute(
        path: "/add_address",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AddAddress())),
    GoRoute(
      path: '/detail/:id', // Menangkap parameter 'id' di URL
      pageBuilder: (context, state) {
        final String id =
            state.pathParameters['id'] ?? ''; // Mengambil nilai id dari URL
        return NoTransitionPage(
            child: DetailCostum(id: id)); // Mengoper id ke halaman DetailCostum
      },
    ),
    GoRoute(
      path: '/detail/user/:id',
      pageBuilder: (context, state) {
        final String id = state.pathParameters['id'] ?? '';
        return NoTransitionPage(child: DetailProductUser(id: id));
      },
    ),
    GoRoute(
        path: "/confirm-payment",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ConfirmPayment())),
    GoRoute(
        path: "/my-order",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MyOrder())),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) {
        final token = state.uri.queryParameters['token'] ?? '';
        return NoTransitionPage(
          child: ForgotPassword(token: token),
        );
      },
    ),
    GoRoute(
        path: "/add-costum",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AddCostum())),
    GoRoute(
        path: "/change-password",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ChangePassword())),
    GoRoute(
        path: "/detail-history",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: DetailHistory())),
    GoRoute(
        path: "/history-tenant",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HistoryTenant())),
    GoRoute(
        path: "/costum-tenant",
        pageBuilder: (context, state) => NoTransitionPage(child: MyRental())),
    GoRoute(
        path: "/banner",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Banners())),
    GoRoute(
        path: "/add-banner",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CreateBanner())),
    GoRoute(
        path: "/category",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Category())),
    GoRoute(
        path: "/add-category",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CreateCategory())),
    GoRoute(
        path: "/payment",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Payment())),
    GoRoute(
        path: "/create-store",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CreateStore())),
    GoRoute(
        path: "/splash",
        pageBuilder: (context, state) =>
            NoTransitionPage(child: SplashScreen())),
    GoRoute(
        path: "/update-product/:id",
        pageBuilder: (context, state) {
          final String id = state.pathParameters['id'] ?? '';
          return NoTransitionPage(child: UpdateCostum(id: id));
        })
  ]);
}
