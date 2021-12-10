import 'package:flutter/material.dart';
import 'package:smarty_home/pages/login.dart';
import 'package:smarty_home/pages/login_options.dart';
import 'package:smarty_home/pages/menu.dart';
import 'package:smarty_home/pages/splash.dart';
import 'package:smarty_home/pages/temperature_analysis.dart';

void main() => runApp(MaterialApp(
      title: 'Smarty Home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Splash(),
        '/login_options': (context) => const LoginOptions(),
        '/login': (context) => const Login(),
        '/menu': (context) => const Menu(),
        '/temperature_analysis': (context) => const TemperatureAnalysis(),
      },
    ));
