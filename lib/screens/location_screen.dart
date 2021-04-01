import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

import '../services/location.dart';
import '../utilities/constants.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel();
  int temperature;
  var city, longitude, latitude;
  String weatherIcon, weatherMessage, temp;
  AnimationController _controller;
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(
      () {
        if (weatherData == null) {
          temp = '';
          city = '';
          weatherIcon = '   Error';
          weatherMessage = "No data available";
          return;
        } else {
          int condition = weatherData['weather'][0]['id'];
          //print(condition);
          temperature = weatherData['main']['temp'].toInt();
          temp = temperature.toString() + "°C";
          city = weatherData["name"];
          weatherIcon = weatherModel.getWeatherIcon(condition);
          weatherMessage = weatherModel.getMessage(temperature) + "in $city";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.gps_fixed,
                      size: 30.0,
                    ),
                  ),
                  Text(
                    date.day.toString() +
                        "/" +
                        date.month.toString() +
                        "/" +
                        date.year.toString(),
                    textAlign: TextAlign.center,
                    style: kDateTextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() async {
                        var typedName =
                            await Navigator.pushNamed(context, '/city');
                        print(typedName);
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        temp,
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 35),
                child: Text(
                  "$weatherMessage",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*


print("Longitude: " +
longitude.toString() +
", Latitude: " +
latitude.toString());

print(temperature.toStringAsFixed(1) + "°C");
print("City: " + city.toString());*/
