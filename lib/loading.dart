import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mausam/worker.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  late String city = 'lucknow';
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String icon;

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp!;
    humidity = instance.humidity!;
    air_speed = instance.air_speed!;
    description = instance.description!;
    icon = instance.icon!;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'main', arguments: {
        'temp_value': temp,
        'humidity_value': humidity,
        'air_speed': air_speed,
        'description': description,
        'icon_value': icon,
        'city_value': city
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? search =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (search?.isNotEmpty ?? false) {
      city = search?['searchText'];
    }
    startApp(city);

    return Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 350,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Mausam App',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Made By Anish',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ));
  }
}
