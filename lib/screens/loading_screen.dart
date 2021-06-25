
import 'package:clima/services/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:delayed_display/delayed_display.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  dynamic weatherdata;

@override
void initState(){
  super.initState();
  getLocationData();
}

  dynamic getLocationData()async{
  WeatherModel weathermodel=WeatherModel();
  dynamic weatherData=await weathermodel.getLocationdata();
  weatherdata=weatherData;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen(weatherData:weatherdata )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitHourGlass(
            color: Colors.orangeAccent,
            size: 110.0,),

            DelayedDisplay(
              delay: Duration(seconds: 10),
              child:Container(decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 40,
                child: Center(
                  child:
                      Text(
                        "Check your internet connection !",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),

                ),
              ),
            ),

          ],
        )
      )
    );
  }
}


