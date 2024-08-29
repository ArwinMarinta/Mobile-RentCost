import 'package:RentCost/features/view/category.dart';
import 'package:RentCost/features/view/home.dart';
import 'package:RentCost/features/view/profile.dart';
import 'package:RentCost/features/view/shopping.dart';
import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

GoRouter goRouter() {
  return GoRouter(initialLocation: "/", routes: [
    GoRoute(
        path: "/",
        pageBuilder: (context, state) => const NoTransitionPage(child: Home())),
    GoRoute(
        path: "/shop",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Shopping())),
    GoRoute(
        path: "/category",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Category())),
    GoRoute(
        path: "/profile",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: Profile()))
  ]);
}