import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarty_home/widgets/logo.dart';
import 'package:smarty_home/widgets/smarty_card.dart';

class HomeStatus extends StatelessWidget {
  const HomeStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            stops: [0.1, 0.5, 0.9, 1.0],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
        child: SafeArea(
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
              Positioned(
                top: 4,
                right: 4,
                child: BounceInRight(
                  child: Row(
                    children: [
                      const Text(
                        'welcome',
                        style: TextStyle(
                            fontFamily: 'Designer',
                            color: Colors.white,
                            fontSize: 32,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                      SvgPicture.asset(
                        "assets/svgs/logo.svg",
                        height: 95,
                      ),
                    ],
                  ),
                ),
              ),
              BounceInUp(child: generateCards())
            ],
          ),
        ),
      ),
    );
  }

  Wrap generateCards() {
    return Wrap(spacing: 8, runSpacing: 8, children: const [
      SmartyCard(
        title: "temperature",
        svgName: "temperature",
      ),
      SmartyCard(
        title: "humidity",
        svgName: "humidity",
      ),
      SmartyCard(
        title: "gas",
        svgName: "gas",
      ),
      SmartyCard(
        title: "drain",
        svgName: "drain",
      ),
    ]);
  }
}
