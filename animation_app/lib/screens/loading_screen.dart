import 'package:animation_app/utils/location.dart';
import 'package:animation_app/utils/weather.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      print("Konum bilgileri gelmiyor.");
    } else {
      print("latitude: " + locationData.latitude.toString());
      print("longitude: " + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("API den sıcaklık veya durum bilgisi boş dönüyor.");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF4e89ae),
                Color(0xFFa2d5f2),
                Color(0xFF4e89ae)
              ]),
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
