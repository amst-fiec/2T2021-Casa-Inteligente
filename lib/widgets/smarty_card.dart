import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmartyCard extends StatelessWidget {
  final String? title;
  final String? svgName;
  const SmartyCard({Key? key, this.title, this.svgName = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double widthCard = (size.width < 500) ? size.width * 0.4375 : 180.0;
    double heightCard = (size.width < 500) ? size.width * 0.6090 : 230.0;

    return RawMaterialButton(
      elevation: 4.5,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(20)),
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.1),
      onPressed: () {},
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              )),
          width: 170,
          height: 230,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Designer',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SvgPicture.asset(
                "assets/svgs/$svgName.svg",
                height: heightCard * 0.45,
              ),
              const Text(
                "value",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Designer',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Container(
                height: 8,
              ),
              Text(
                "state",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Designer',
                    fontWeight: FontWeight.w600,
                    color: ([
                      Colors.orange[500],
                      Colors.redAccent[400],
                      Colors.lightGreenAccent[400],
                    ]..shuffle())
                        .first),
              ),
            ],
          )),
    );
  }
}
