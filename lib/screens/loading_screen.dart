import 'package:flutter/material.dart';
import 'package:my_weather_app/screens/location_screen.dart';
import 'package:my_weather_app/services/location.dart';
import 'package:my_weather_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'a5f8ee06df5e1566a6a8eabcbaec7f3a';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async{
  Location location = Location();
  await location.getCurrentLocation();
  NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

  var weatherData = await networkHelper.getData();
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return LocationScreen(weatherData);
  }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.teal,
          size: 100.0,
        ),
      ),

    );
  }
}
