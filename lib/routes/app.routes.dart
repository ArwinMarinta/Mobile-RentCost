import 'package:RentCost/features/view/add_address.dart';
import 'package:RentCost/features/view/cart.dart';
import 'package:RentCost/features/view/category.dart';
import 'package:RentCost/features/view/home.dart';
import 'package:RentCost/features/view/login.dart';
import 'package:RentCost/features/view/profile.dart';
import 'package:RentCost/features/view/register.dart';
import 'package:RentCost/features/view/search.dart';
import 'package:RentCost/features/view/select_address.dart';
import 'package:RentCost/features/view/shop.dart';
import 'package:RentCost/features/view/verify_email.dart';
// import 'package:RentCost/features/view/shopping.dart';
import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: "/", routes: [
    GoRoute(
        path: "/",
        pageBuilder: (context, state) => const NoTransitionPage(child: Home())),
    GoRoute(
        path: "/shop",
        pageBuilder: (context, state) => const NoTransitionPage(child: Shop())),
    GoRoute(
        path: "/category",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Category())),
    GoRoute(
        path: "/profile",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Profile())),
    GoRoute(
        path: "/search",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Search())),
    GoRoute(
        path: "/login",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Login())),
    GoRoute(
        path: "/register",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Register())),
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
  ]);
}
