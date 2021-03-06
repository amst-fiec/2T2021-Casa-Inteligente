import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarty_home/widgets/logo.dart';

class TemperatureAnalysis extends StatelessWidget {
  const TemperatureAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    const itemColor = Color(0xff9c9ccc);
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xfff3f3f2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff93dfe4),
              Color(0xff9cb3dd),
              Color(0xffc3a8df),
              Color(0xffdfbbe3)
            ],
            stops: [0.0, 0.3, 0.8, 0.9],
            begin: FractionalOffset.topRight,
            end: FractionalOffset.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: FadeIn(
            duration: const Duration(milliseconds: 600),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: 4,
                  left: 4,
                  child: IconButton(
                    tooltip: 'Back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),
                const Positioned(
                  top: 48,
                  child: Logo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BounceInUp(
                        child: const Icon(
                          Icons.thermostat,
                          color: Colors.white,
                          size: 64,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
