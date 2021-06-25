import 'package:clima/Location_Detector.dart';
import 'package:clima/services/networking.dart';
const kApiKey='bcd7ab4e493090dcfd9566215298d422';


class WeatherModel {

 Future getCityWeather(String cityName)async{
   var Qrameters={
     'q':cityName,
     'appid':kApiKey,
     'units':'metric'
   };
   NetworkingData networking=NetworkingData(Uri.https('api.openweathermap.org', '/data/2.5/weather',Qrameters));
   var weatherData=await networking.getData();
   return weatherData;
 }

Future getLocationdata()async{
  locationDetector location=locationDetector();
  await location.getLocation();

  var QPrameters={
    'lat':'${location.latitude}',
    'lon':'${location.longitude}',
    'appid':kApiKey,
    'units':'metric'
  };
  NetworkingData networking=NetworkingData(Uri.https('api.openweathermap.org', '/data/2.5/weather',QPrameters));
  var weatherData=await networking.getData();
  return weatherData;
}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time in';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in';
    } else {
      return 'Bring a 🧥 just in case in';
    }
  }
}
