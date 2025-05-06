import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_app/views/home_page.dart';
import 'package:restaurant_app/views/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: _splashLogo(),
      nextScreen: const HomePage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }

  Row _splashLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png'),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Waroeng ',
          style: myTextTheme.headlineSmall,
        ),
        Text(
          'Kita',
          style: myTextTheme.headlineSmall!.copyWith(
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}
