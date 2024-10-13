import 'package:RentCost/features/view/add_address.dart';
import 'package:RentCost/features/view/add_costum.dart';
import 'package:RentCost/features/view/cart.dart';
import 'package:RentCost/features/view/category.dart';
import 'package:RentCost/features/view/change_password.dart';
import 'package:RentCost/features/view/confirm_payment.dart';
import 'package:RentCost/features/view/create_banner.dart';
import 'package:RentCost/features/view/create_category.dart';
import 'package:RentCost/features/view/detail_costum.dart';
import 'package:RentCost/features/view/detail_history.dart';
import 'package:RentCost/features/view/forgot_password.dart';
import 'package:RentCost/features/view/history_tenant.dart';
import 'package:RentCost/features/view/home.dart';
import 'package:RentCost/features/view/login.dart';
import 'package:RentCost/features/view/my_order.dart';
import 'package:RentCost/features/view/my_rental.dart';
import 'package:RentCost/features/view/payment.dart';
import 'package:RentCost/features/view/personal.dart';
import 'package:RentCost/features/view/profile.dart';
import 'package:RentCost/features/view/register.dart';
import 'package:RentCost/features/view/search.dart';
import 'package:RentCost/features/view/select_address.dart';
import 'package:RentCost/features/view/shop.dart';
import 'package:RentCost/features/view/verify_email.dart';
import 'package:RentCost/features/view/banner.dart';

// import 'package:RentCost/features/view/shopping.dart';
import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: "/payment", routes: [
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
    GoRoute(
        path: "/detail",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: DetailCostum())),
    GoRoute(
        path: "/personal",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Personal())),
    GoRoute(
        path: "/confirm-payment",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ConfirmPayment())),
    GoRoute(
        path: "/my-order",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MyOrder())),
    GoRoute(
        path: "/forgot-password",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ForgotPassword())),
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
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MyRental())),
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
  ]);
}
