import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/constants.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/screens/login_screen.dart';

import '../blocs/auth/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print('Listener at Splash');
          print(state.status.name.toString());
          if (state.status == AuthStatus.unauthenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamed(LoginScreen.routeName),
            );
          } else if (state.status == AuthStatus.authenticated) {
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamed(HomeScreen.routeName),
            );
          }
        },
        child: const Scaffold(
          backgroundColor: kSecondaryColor,
          body: Center(
            child: Text('Splash Screen'),
          ),
        ),
      ),
    );
  }
}
