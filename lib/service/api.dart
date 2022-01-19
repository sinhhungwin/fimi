import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fimi/models/weather_model.dart';
import 'package:fimi/utils/enviroment.dart';

Future<WeatherModel> fetchWeather() async {
  final response = await http.get(urlApi +
      'v2/city?city=Hanoi&state=Hanoi&country=Vietnam&key=' +
      keyApi);

  if (response.statusCode == 200) {
    var res = json.decode(response.body);

    print(res.toString());

    return WeatherModel.fromJson(res);
  } else {
    throw Exception('Failed to get city pollution data');
  }
}
