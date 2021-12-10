import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

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
            begin: FractionalOffset.bottomRight,
            end: FractionalOffset.topLeft,
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
                  right: 4,
                  child: IconButton(
                    tooltip: 'Exit',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 48,
                  child: Image.asset(
                    'images/logo.png',
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        style: buttonStyle,
                        onPressed: () {},
                        label: const Text(
                          'smarty home status',
                          style: TextStyle(
                            color: itemColor,
                            fontFamily: 'Designer',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            letterSpacing: 0.75,
                          ),
                        ),
                        icon: const Icon(
                          Icons.home,
                          color: itemColor,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: buttonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/temperature_analysis');
                        },
                        label: const Text(
                          'temperature analysis',
                          style: TextStyle(
                            color: itemColor,
                            fontFamily: 'Designer',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            letterSpacing: 0.75,
                          ),
                        ),
                        icon: const Icon(
                          Icons.thermostat,
                          color: itemColor,
                        ),
                      ),
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
