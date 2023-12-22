import 'package:flutter/material.dart';
import 'package:pokedex/screens/login_screen.dart';
import 'package:pokedex/screens/signup_screen.dart';

import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This route is ${settings.name}');

    switch (settings.name) {
      case '/':
        return SplashScreen.route();
      case '/login':
        return LoginScreen.route();
      case '/signup':
        return SignupScreen.route();
      case '/home':
        return HomeScreen.route();

      default:
        return _errorRoute.route();
    }
  }
}

class _errorRoute extends StatelessWidget {
  const _errorRoute({super.key});

  static const String routeName = '/error';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const _errorRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('Error Route'),
      ),
    );
  }
}
