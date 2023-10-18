import 'dart:convert';

import 'package:http/http.dart';

class worker {
  String location;

  worker({required this.location}) {
    location = this.location;
  }
  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? icon;

  Future<void> getData() async {
    try {
      var url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=93225096b5d38075fcd69abb29e42cbc");
      var response = await get(url);
      Map data = jsonDecode(response.body);
      // print('Response body: ${response.body}');
      // print(data['weather']);
      // Map main_data = data['main'];
      // double temp = main_data['temp'];
      // print(temp);
      // List weather_data = data['weather'];
      // Map weather_data_map = weather_data[0];
      // String main = weather_data_map['main'];
      // print(main);

      // weather - main data
      List weather_data = data['weather'];
      Map weather_data_map = weather_data[0];
      String get_desc = weather_data_map['description'];
      String get_icon = weather_data_map['icon'];

      // main - temp  data
      Map main_data = data['main'];

      double get_temp = main_data['temp']; // temp  kelvin
      double get_temp_change = get_temp - 273.15; // celsius

      int get_humidity = main_data['humidity']; // humidity

      // wind - speed data
      Map wind_data = data['wind'];
      double get_wind = wind_data['speed']; //   meter/second
      double get_wind_change = get_wind * 3.6; // kilometer/second

      // Assigning value
      temp = get_temp_change.toString();
      humidity = get_humidity.toString();
      air_speed = get_wind_change.toString();
      description = get_desc;
      icon = get_icon;
    } catch (e) {
      temp = "No";
      humidity = "wait";
      air_speed = "wait";
      description = "No data";
      icon = "50n";
    }
  }
}
