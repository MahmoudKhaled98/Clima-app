import'package:geolocator/geolocator.dart';

class locationDetector{
  double longitude;
  double latitude;
  Future<void> getLocation()async{
    try{ Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    longitude=position.longitude;
    latitude=position.latitude;
    }
    catch(e){
      print(e);
    }
  }
}