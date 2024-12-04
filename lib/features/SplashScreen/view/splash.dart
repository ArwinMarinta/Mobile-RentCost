import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_bloc.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_event.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(CheckTokenEvent());

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToDashboard) {
          context.go('/');
        } else if (state is SplashNavigateToLogin) {
          context.go("/login");
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading) {
                return const CircularProgressIndicator();
              }
              return Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/rencost_logo.png"),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
