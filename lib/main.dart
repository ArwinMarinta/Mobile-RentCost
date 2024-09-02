import 'package:flutter/material.dart';
import 'package:RentCost/routes/app.routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rent Cost',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(136, 31, 255, 5.0)),
        useMaterial3: true,
      ),
      routerConfig: goRouter(),
    );
  }
}
