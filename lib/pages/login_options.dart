import 'package:animate_do/animate_do.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarty_home/widgets/logo.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({Key? key}) : super(key: key);

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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff93dfe4),
            Color(0xff9cb3dd),
            Color(0xffc3a8df),
            Color(0xffdfbbe3)
          ],
          stops: [0.0, 0.3, 0.8, 0.9],
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
        ),
      ),
      child: SafeArea(
        child: FadeIn(
          duration: const Duration(milliseconds: 600),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const Positioned(
                top: 48,
                child: Logo(),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      label: const Text(
                        'sign in',
                        style: TextStyle(
                          color: itemColor,
                          fontFamily: 'Designer',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 0.75,
                        ),
                      ),
                      icon: const Icon(
                        Icons.mail_outline_rounded,
                        color: itemColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 48,
                            height: 2,
                            color: Colors.white,
                          ),
                          const Text(
                            'OTHER SIGN IN OPTIONS',
                            style: TextStyle(
                              fontFamily: 'Designer',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 2,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/menu');
                        },
                        child: const Icon(
                          CommunityMaterialIcons.google,
                          color: itemColor,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
