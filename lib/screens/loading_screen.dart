import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final spinkit = SpinKitChasingDots(
  color: Colors.lightBlueAccent,
  size: 100.0,
);

class LoadingScreen extends StatefulWidget {
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel()
        .getLocationWeather()
        .timeout(Duration(seconds: 2), onTimeout: () {
      return null;
    });
    Navigator.popUntil(context, ModalRoute.withName('/location'));
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
