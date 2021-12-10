import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smarty_home/utilities/authentication.dart';
import 'package:smarty_home/widgets/logo.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Authentication.initializeFirebase();
    Future.delayed(const Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, '/login_options');
      } else {
        Navigator.pushReplacementNamed(context, '/menu');
      }
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
              child: const Logo(),
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

Future<User?> currentUser() async {
  final GoogleSignInAccount? account = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? authentication =
      await account?.authentication;

  final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: authentication?.idToken,
      accessToken: authentication?.accessToken);

  final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
  final User? user = authResult.user;

  return user;
}
