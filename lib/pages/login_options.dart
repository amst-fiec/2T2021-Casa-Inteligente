import 'dart:async';
import 'dart:developer' as developer;

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarty_home/widgets/google_sign_in_button.dart';
import 'package:smarty_home/widgets/logo.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  
  }


  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }


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
              Positioned(
                top: 48,
                child: BounceInDown(child: const Logo()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: AbsorbPointer(
                  absorbing: _connectionStatus == ConnectivityResult.none,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity((_connectionStatus == ConnectivityResult.none)?0.075:0.0),
                      BlendMode.srcATop,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BounceInLeft(
                          child: ElevatedButton.icon(
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
                        BounceInRight(child: const GoogleSignInButton()),
                        const SizedBox(height: 50),
                        
                        !(_connectionStatus == ConnectivityResult.none)?Container():const Center(
                          child: Text(
                                  'No hay conexion a internet',
                                  style: TextStyle(
                                    fontFamily: 'Designer',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
