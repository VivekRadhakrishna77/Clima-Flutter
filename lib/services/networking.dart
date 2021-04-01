import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/screens/loading_screen.dart';

class Networking {
  Networking(this.url);

  final String url;

  getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      print("Error: " + response.statusCode.toString());
    }
  }
}
