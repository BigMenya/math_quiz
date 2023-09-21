import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/constants.dart';

class WelcomeScreenWidget extends StatefulWidget {
  const WelcomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenWidget> createState() => _WelcomeScreenWidgetState();
}

class _WelcomeScreenWidgetState extends State<WelcomeScreenWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'assets/splash_lottie.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height * 1,
        animate: true,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete(
                () => Navigator.pushNamed(context, Constants.quizScreenRoute));
        },
      ),
    );
  }
}
