import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/blocs/auth/auth_bloc.dart';
import 'package:pokedex/config/app_router.dart';
import 'package:pokedex/cubits/home/home_cubit.dart';
import 'package:pokedex/cubits/login/login_cubit.dart';
import 'package:pokedex/cubits/singnup/signup_cubit.dart';
import 'package:pokedex/repositories/auth_repository.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/screens/splash_screen.dart';

import 'blocs/internet_bloc/internet_bloc.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => PokeApiRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<InternetBloc>(
            create: (context) => InternetBloc(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              pokemonRepository: context.read<PokeApiRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Pokedex App',
          theme: themeData,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

ThemeData themeData = ThemeData(
  primaryColor: kPrimaryColor,
  // Custom primary color
  fontFamily: 'Montserrat',
  colorScheme: const ColorScheme.light(primary: kPrimaryColor),
  // Custom font family
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black, // Custom text color
      fontSize: 20.0, // Custom font size
      fontWeight: FontWeight.bold, // Custom font weight
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFFFFCC00), // Custom accent color for buttons
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Custom button border radius
    ),
  ),
);
