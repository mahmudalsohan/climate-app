import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';

class Networking {
  double latitude;
  double longitude;
  static const _apiKey = 'ddc44cc9b9ea7c873ce7c1a71e3430ea';

  void getLocation() async {
    Location location = Location();

    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$_apiKey'));

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodeData = jsonDecode(data);

      double temperature = decodeData['main']['temp'] - 273; //main.temp
      String condition = decodeData['weather'][0]['main']; //weather[0].main
      String cityName = decodeData['name']; //name

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }
}
