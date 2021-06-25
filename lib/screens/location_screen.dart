import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel=WeatherModel();
  String typedName;
  int temperature;
  var cond;
  var cityName;
  String weatherMessage;
  String weatherIcon;
@override
void initState(){
  super.initState();
  updateUI(widget.weatherData);
}


updateUI(weatherData){
    setState(() {
      if(weatherData==null){
        temperature=0;
        cityName='';
        weatherMessage='Error with getting data';
        weatherIcon='Error';
        return;
      }
      double temp= weatherData['main']['temp'];
      temperature=temp.toInt();
      weatherMessage=weatherModel.getMessage(temperature);

      cond=weatherData['weather'][0]['id'];
      weatherIcon=weatherModel.getWeatherIcon(cond);

      cityName=weatherData['name'];
      weatherModel.getLocationdata();
    });

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
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{var weatherData=await weatherModel.getLocationdata();
                    updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),

                  FlatButton(
                    onPressed: ()async {
                     typedName= await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));
                    if(typedName!=null){
                      var weatherData=await weatherModel.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 250,),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                 '${weatherMessage} ${cityName}',
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}

