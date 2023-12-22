import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/blocs/auth/auth_bloc.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'package:pokedex/screens/signup_screen.dart';
import 'package:pokedex/screens/splash_screen.dart';
import 'package:pokedex/widgets/custom_elevated_button.dart';
import 'package:pokedex/widgets/custom_text_field.dart';

import '../constants.dart';
import '../cubits/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (BuildContext context) {
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.authenticated
              ? const HomeScreen()
              : const LoginScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.email != current.email,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: Text(
                          'Pokemon Missed You!',
                          style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20,),
                CustomTextField(
                  hint: 'Enter Your Email',
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    context.read<LoginCubit>().emailChanged(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Enter Your Password',
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    context.read<LoginCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  text: 'Login',
                  beginColor: Theme.of(context).primaryColor,
                  endColor: kSecondaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<LoginCubit>().loginWithCredential();
                  },
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SignupScreen.routeName,
                      ModalRoute.withName('/'),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(text: 'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                              text: ' Signup',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ]),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
