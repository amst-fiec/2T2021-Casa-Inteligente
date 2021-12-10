import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarty_home/widgets/logo.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    const itemColor = Color(0xff9c9ccc);
    const backgroundColor = Color(0xfff3f3f2);
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
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
            stops: [0.0, 0.3, 0.8, 1.0],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
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
                      BounceInLeft(
                        child: const TextField(
                          style: TextStyle(
                              color: itemColor,
                              fontFamily: 'Designer',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: itemColor),
                              hintText: "email",
                              fillColor: backgroundColor,
                              filled: true),
                        ),
                      ),
                      Container(
                        height: 16,
                      ),
                      BounceInRight(
                        child: const TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                              color: itemColor,
                              fontFamily: 'Designer',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: itemColor),
                              hintText: "password",
                              fillColor: backgroundColor,
                              filled: true),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 80,
                    child: BounceInUp(
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, '/menu');
                        },
                        child: const Text(
                          'continue',
                          style: TextStyle(
                              fontFamily: 'Designer',
                              color: itemColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
