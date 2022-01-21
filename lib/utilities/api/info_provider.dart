
import 'dart:convert';

import 'package:http/http.dart' as http;

class InfoProvider {
  
  Future<Map> getInfo() async{
    final Map <String, dynamic> decodedData;
    var uri = Uri.parse('https://smarty-home-37755-default-rtdb.firebaseio.com/sensores.json');
    
    var response = await http.get(uri);
    if (response.statusCode == 200) {
       decodedData = jsonDecode(response.body);
    }
    else {
      decodedData = {};
    }

    return decodedData;
  }


}