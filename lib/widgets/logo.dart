import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/svgs/logo.svg",
          height: 95,
        ),
        const Text(
          'smarty',
          style: TextStyle(
              fontFamily: 'Designer',
              color: Colors.white,
              fontSize: 32,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
        const Text(
          'home',
          style: TextStyle(
              fontFamily: 'Designer',
              color: Colors.white,
              fontSize: 24,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
