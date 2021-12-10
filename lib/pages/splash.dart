import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login_options');
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff9cece4),
            Color(0xff93dfe4),
            Color(0xff9cb3dd),
            Color(0xffc3a8df),
            Color(0xffdfbbe3)
          ],
          stops: [0.1, 0.3, 0.5, 0.7, 0.9],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            FadeIn(
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'images/logo.png',
                height: 150,
              ),
            ),
            const Positioned(
              bottom: 48,
              child: SpinKitSpinningLines(
                color: Colors.white,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
