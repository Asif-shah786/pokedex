import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubits/singnup/signup_cubit.dart';
import 'package:pokedex/cubits/singnup/signup_cubit.dart';
import 'package:pokedex/screens/login_screen.dart';
import 'package:pokedex/widgets/custom_elevated_button.dart';
import 'package:pokedex/widgets/custom_text_field.dart';

import '../constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const SignupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: const Text(
                          'Pokemon Say\'s Wellcome',
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
                const SizedBox(height: 20,),
                CustomTextField(
                  hint: 'Enter Your Email',
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    context.read<SignupCubit>().emailChanged(value);
                    print('email: $value');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Enter Your Password',
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    context.read<SignupCubit>().passwordChanged(value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  text: 'Sign Up',
                  beginColor: Theme.of(context).primaryColor,
                  endColor: kSecondaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    await context.read<SignupCubit>().signupWithCredential();
                  },
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routeName,
                      ModalRoute.withName('/'),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(text: 'Already have an account ?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                      TextSpan(
                          text: 'Login',
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
