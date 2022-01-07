import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarty_home/widgets/logo.dart';
import 'package:smarty_home/widgets/smarty_card.dart';

class HomeStatus extends StatefulWidget {
  const HomeStatus({Key? key}) : super(key: key);

  @override
  State<HomeStatus> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus> {

  List values = [0.0,0.0,0.0,0.0];
  List<int> priorities = [0,0,0,0];
  List<String> states = ["State","State","State","State"];
  int valoor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    values = [20.0,50.0,60.0,50.0];
    checkTemperature(values[0]);
    checkHumidity(values[1]);
    checkGas(values[2]);
    checkDrain(values[3]);


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
                        height: 85,
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

    return Wrap(spacing: 8, runSpacing: 8, children:  [
      SmartyCard(
        title: "temperature",
        svgName: "temperature",
        units: "°C",
        state: states[0],
        value: values[0],
        prioritie: priorities[0],
      ),
      SmartyCard(
        title: "humidity",
        svgName: "humidity",
        units: "%",
        state: states[1],
        value: values[1],
        prioritie: priorities[1],
      ),
      SmartyCard(
        title: "gas",
        svgName: "gas",
        units: "ppm",
        state: states[2],
        value: values[2],
        prioritie: priorities[2],
      ),
      SmartyCard(
        title: "drain",
        svgName: "drain",
        units: "db",
        state: states[3],
        value: values[3],
        prioritie: priorities[3],
      ),
    ]);
  }


  void checkDrain(double value) {
    if(value > 400.0){
      priorities[3] = 3;
      states[3] = "Obstrucción detectada";
  }else{
      priorities[3] = 1;
      states[3] = "Sin problemas";
  }
  

}


void checkTemperature(double value){
  setState(() {
    
  });
  String text;
  int status = 1;
  if(value < 22.0){
    text = "Peligro, muy frío";
    status = 3;
  }
  else if(value >= 22.0 && value < 24.0){
   text = "Frío";
    status = 2;
  }
  else if(value >= 24.0 && value < 25.0){
    text = "Confortable";
    status = 1;
  }
  else if(value >= 25.0 && value < 27.0){
    text = "Caliente";
    status = 3;
  }
  else{
    text = "Peligro, sofocante";
    status = 3;
  }
  priorities[0] = status;
  states[0] = text;

}

void checkGas(double value){
  String text;
  bool sendAlert = true;
  int status = 1;
  if(value < 50.0){
    text = "Gas de nivel normal";
    sendAlert = false;
    status = 1;
  }
  else if(value >= 50.0 && value < 90.0){
   text = "Peligro de posible incendio";
    status = 2;
  }
  else if(value >= 90.0 && value < 159.0){
    text = "Peligro de incendio";
    status = 3;
  }
  else{
    text = "Peligro de intoxicación";
    status = 3;
  }

  priorities[2] = status;
  states[2] = text;


  
}

void checkHumidity(double value){
  String text = "";
  bool sendAlert = true;
  int status = 1;
  if(value >= 50.0){
    text = "Electricidad estática";
    sendAlert = false;
    status = 3;
  }
  else if(value >= 33.0 && value < 40.0){
   text = "Confortable";
    status = 1;
  }
  priorities[1] = status;
  states[1] = text;
  }

  




}
