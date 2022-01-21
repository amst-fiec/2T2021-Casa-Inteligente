import 'dart:async';
import 'dart:developer' as developer;
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarty_home/utilities/api/info_provider.dart';
import 'package:smarty_home/widgets/smarty_card.dart';

import '../utilities/authentication.dart';

class HomeStatus extends StatefulWidget {
  const HomeStatus({Key? key}) : super(key: key);

  @override
  State<HomeStatus> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;




  List values = [24.5,35.0,1.0,100.0]; // [temperature, humidity, gas, drain]
  List<int> priorities = [1,1,1,1];
  List<String> states = ["State","State","State","State"];
  late Timer timer;
  List<int> qntyOf5Secs = [0,0,0,0];
  
  bool manyAlerts = false;
  int qntyOfManyAlerts5Secs = 0;
  
  bool alertDisplay = false;

  var infoProvider = InfoProvider();

  Text confort = const Text("");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getValues();
    timer = Timer.periodic(const Duration(seconds: 5), (_) => getValues());
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
    void dispose() {
    _connectivitySubscription.cancel();
    timer.cancel();
    super.dispose();
  }


  Future<void> _showMyDialog(String title, List<Widget> body ) async {
    if(alertDisplay == false){
      alertDisplay = true;
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xff9cb3dd),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(20)
           ),
            title:  Text(title,
              style: TextStyle(
                fontFamily: 'Designer',
                color: Colors.redAccent[400],
                fontSize: 24,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),),
            content: SingleChildScrollView(
              child: ListBody(
                children: body,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  const Text(
                  'Entendido', 
                  // style:  TextStyle(
                  //   fontFamily: 'Designer',
                  //   fontSize: 16,
                  //   decoration: TextDecoration.none,
                  //   fontWeight: FontWeight.bold),
                    ),
              
                onPressed: () {
                  alertDisplay = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }




  void getValues() async {
    if(_connectionStatus != ConnectivityResult.none){
      Map decodedData = await infoProvider.getInfo();
      if (decodedData!= {}){
        setState(() {
          values[0] = double.parse(decodedData["temperature"]);
          values[1] = double.parse(decodedData["humidity"]);
          values[2] = double.parse(decodedData["gas"]);
          values[3] = double.parse(decodedData["sound"]);
        });
    }}

    int qntyOfAlerts = priorities.where((element) => element == 3).length;
    
    if( qntyOfAlerts> 1){
      manyAlerts = true;
      if(qntyOfManyAlerts5Secs == 0){
        _showMyDialog("Múltiples alertas", [Text('Urgente: Revisar $qntyOfAlerts problemas',style: const TextStyle(color: Colors.white),)] );
          
          
      }else if(qntyOfManyAlerts5Secs%3 == 0){
          // mayor urgencia
        _showMyDialog("Alerta", [
          Text("Han pasado $qntyOfManyAlerts5Secs minutos sin que se hayan resuelto todos los problemas", style: const TextStyle(color: Colors.white),),
          Text('Urgente: Revisar $qntyOfAlerts problemas', style: const TextStyle(color: Colors.white),),
        ]);
          
      }
        
        qntyOfManyAlerts5Secs += 1;
    }else{
      qntyOfManyAlerts5Secs = 0;
      manyAlerts = false;
    } 

    checkGas(values[2]);
    checkDrain(values[3]);
    checkTemperature(values[0]);
    checkHumidity(values[1]);


    confort = getConfort();
  }


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
                  right: 4,
                  child: IconButton(
                    tooltip: 'Exit',
                    onPressed: () {
                      Authentication.signOut(context: context);
                      Navigator.pushReplacementNamed(context, '/login_options');
                    },
                    icon: const Icon(Icons.logout_rounded),
                    color: Colors.white,
                  ),
                ),
              Positioned(
                top: 4,
                left: 4,
                child: BounceInRight(
                  child: Row(
                    children: [
                     
                      SvgPicture.asset(
                        "assets/svgs/logo.svg",
                        height: 85,
                      ),
                       const Text(
                        'Bienvenido',
                        style: TextStyle(
                            fontFamily: 'Designer',
                            color: Colors.white,
                            fontSize: 32,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              
              BounceInUp(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Estado de Confort: ',
                        style: TextStyle(
                            fontFamily: 'Designer',
                            color: Colors.white,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                      confort
                    ],
                  ),
                  const SizedBox(height: 20,),
                  generateCards(),
                  const SizedBox(height: 25,),
                  !(_connectionStatus == ConnectivityResult.none)?Container():Center(
                    child: Column(
                      children: const [
                        Text(
                          'Datos no actualizados, revisar conexión a internet',
                          style: TextStyle(
                            fontFamily: 'Designer',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 10,),
                        CircularProgressIndicator(color: Colors.white,)
                              
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
      
  }



  Wrap generateCards() {

    return Wrap(spacing: 8, runSpacing: 8, children:  [
      SmartyCard(
        title: "temperatura",
        svgName: "temperature",
        units: "°C",
        state: states[0],
        value: values[0],
        prioritie: priorities[0],
      ),
      SmartyCard(
        title: "humedad",
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
        title: "Desagüe",
        svgName: "drain",
        units: "db",
        state: states[3],
        value: values[3],
        prioritie: priorities[3],
      ),
    ]);
  }


  Text getConfort(){
    String text = "";
    Color? color = Colors.green;
    if (priorities.where((element) => element == 3).isNotEmpty){
      text = "Malo";
      color = Colors.redAccent[400];
    } else if (priorities.where((element) => element == 1).length == 3){
      text = "Bueno";
      color = Colors.green[400];
    } else if (priorities.where((element) => element == 1).length == 4){
      text = "Muy Bueno";
      color = Colors.green[400];
    }else{
      text = "Regular";
      color = Colors.orangeAccent[400];
    }
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Designer',
          color: color,
          fontSize: 24,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold),
    );
  }


  void checkDrain(double value) {
    String text = "";
    int prioritie = 1;
    String alertText = "";
    if(value > 400.0){
      prioritie = 3;
      text = "Obstrucción detectada";
      alertText = "Urgente: Existe una obstrucción en el desagüe";
    }else{
        prioritie = 1;
        text = "Sin problemas";
    }

  checkAlert(prioritie,3,alertText);

  priorities[3] = prioritie;
  states[3] = text;

}


void checkTemperature(double value){
  String text = "";
  String textAlert = "";
  int prioritie = 1;

  if(value < 22.0){
    text = "Peligro, muy frío";
    textAlert = "La temperatura está muy baja";
    prioritie = 3;
  }
  else if(value >= 22.0 && value < 24.0){
   text = "Frío";
    prioritie = 2;
  }
  else if(value >= 24.0 && value < 25.0){
    text = "Confortable";
    prioritie = 1;
  }
  else if(value >= 25.0 && value < 27.0){
    text = "Caliente";
    prioritie = 2;
  }
  else{
    text = "Peligro, sofocante";
    textAlert = "La temperatura está muy alta";
    prioritie = 3;
  }

  checkAlert(prioritie,0,textAlert);



  priorities[0] = prioritie;
  states[0] = text;

}

void checkGas(double value){
  String text = "";
  String alertText = "";
  int prioritie = 1;
  if(value < 50.0){
    text = "Nivel normal";
    prioritie = 1;
  }
  else if(value >= 50.0 && value < 90.0){
   text = "Peligro, posible incendio";
    prioritie = 2;
  }
  else if(value >= 90.0 && value < 159.0){
    text = "Peligro de incendio";
    alertText = "Urgente: Peligro de incendio, atender lo antes posible";
    prioritie = 3;
  }
  else{
    text = "Peligro de intoxicación";
    alertText = "Urgente: Peligro de intoxicación, atender lo antes posible";
    prioritie = 3;
  }
  checkAlert(prioritie,2,alertText);
  priorities[2] = prioritie;
  states[2] = text;


  
}

void checkHumidity(double value){
  String text = "";
  int prioritie = 1;
  if(value >= 50.0){
    text = "Electricidad estática";
    prioritie = 3;
  }
  else if(value >= 33.0 && value < 40.0){
   text = "Confortable";
    prioritie = 1;
  }else if(value < 33.0){
    text = "Poca Humedad";
    prioritie = 2;
  }else {
    prioritie = 2;
    text = "Humedad media";
  }

  checkAlert(prioritie,1,text);

  priorities[1] = prioritie;
  states[1] = text;
  }

  

  void checkAlert(int prioritie, int index, String text){
    if(!manyAlerts && _connectionStatus != ConnectivityResult.none){
      if(prioritie == 3){
      
        if(qntyOf5Secs[index] == 0){
          _showMyDialog("Alerta", [
            Text(text),
          ]);
          
        }else if(qntyOf5Secs[index]%3 == 0){
          // mayor urgencia
          _showMyDialog("Alerta", [
            Text("Han pasado ${qntyOf5Secs[index]*5} minutos desde la primer alerta" ,style: const TextStyle(color: Colors.white),),
            Text(text, style: const TextStyle(color: Colors.white),),
          ]);
          
        }
        
        qntyOf5Secs[index] += 1;

      }else{
        qntyOf5Secs[index] = 0;
      }
    }
  }




}
