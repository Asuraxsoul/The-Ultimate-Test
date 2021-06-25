import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool isChanged = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.05),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutSine,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 3450),
      () => setState(() {
        isChanged = true;
      }),
    );
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacementNamed('/signIn'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: mediaHeight(context),
            width: mediaWidth(context),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            height: mediaHeight(context),
            width: mediaWidth(context),
            child: isChanged
                ? Image.asset(
                    'assets/images/splash.jpg',
                    fit: BoxFit.fitHeight,
                  )
                : SlideTransition(
                    position: _offsetAnimation,
                    child: Image.asset(
                      'assets/images/splashChanged.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
