import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:furniture/presentation/resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorManager.darkBlack,
      body: Center(
        child: SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 45,
                color: Colors.white,
                shadows: [
                  Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0))
                ]),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText('Best Furniture'),
                FlickerAnimatedText('For You'),
                FlickerAnimatedText('Best Furniture'),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
