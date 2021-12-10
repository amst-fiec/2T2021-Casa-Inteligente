import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smarty_home/utilities/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Authentication.initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'conection error',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.redAccent[700],
                fontFamily: 'Designer',
                fontSize: 24,
                letterSpacing: 0.75,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return _isSigningIn
              ? const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 24.0,
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xfff3f3f2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isSigningIn = true;
                    });

                    User? user =
                        await Authentication.signInWithGoogle(context: context);

                    setState(() {
                      _isSigningIn = false;
                    });

                    if (user != null) {
                      Navigator.pushNamed(context, '/menu');
                    }
                  },
                  child: const Icon(
                    CommunityMaterialIcons.google,
                    color: Color(0xff9c9ccc),
                  ));
        }
        return const SpinKitSpinningLines(
          color: Colors.white,
          size: 24.0,
        );
      },
    );
  }
}
