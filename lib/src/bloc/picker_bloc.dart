import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_one/src/data_models/location.dart';

class PickerBloc with ChangeNotifier {
  StreamController<Location> locationController =
  StreamController<Location>.broadcast();

  StreamController<String> addressStreamController = StreamController<String>();

  Stream<String> get getStreamAddress => addressStreamController.stream;

  Location currentLocation =  new Location(lat: 10.85636, lng: 106.6543, formattedAddress: '');
  //static const mapKey = 'USejsslN7JEBkHFGgpCaNgycS2nhTokf4k1cRGhBOvI';

  static PickerBloc _instance;
  static PickerBloc getInstance() {
    if (_instance == null) {
      _instance = PickerBloc._internal();
    }
    return _instance;
  }

  PickerBloc._internal();

  void locationSelected(Location location) {
    locationController.sink.add(location);

  }

  void setLocationByMovingMap(LatLng latLng) {
    getAddress(latLng);
  }

  /*void  getGeolocatorHereAPI(LatLng latLng) async{
    String url = "https://reverse.geocoder.ls.hereapi.com/6.2/reversegeocode.json?apiKey=${mapKey}"
        "&mode=retrieveAddresses&prox=${latLng.latitude},${latLng.longitude}";
    var res = await http.get(url);
    String address = "";
    if (res.statusCode == 200) {
      address = json.decode(res.body)['Response']['View'][0]['Result'][0]['Location']
      ['Address']['Label'].toString();
    }
    currentLocation = Location(lat: latLng.latitude, lng: latLng.longitude, formattedAddress: address);
    addressStreamController.sink.add("$address");

  }*/

  void getAddress(LatLng latLng) async{
    final coordinates = new Coordinates(currentLocation.lat, currentLocation.lng);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String address = first.addressLine.toString();
    currentLocation = Location(lat: latLng.latitude, lng: latLng.longitude, formattedAddress: address);
    addressStreamController.sink.add("$address");
  }

  void _getCurrent(Position position){
    Location location = new Location(lat: position.latitude, lng: position.longitude);
    locationSelected(location);
  }

  Future<void> checkPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }
    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
    await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
        print('disabled');
        break;
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:
        print('Access granted');
        Position position = await geolocator.getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        _getCurrent(position);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('close');
    _instance = null;
    locationController.close();
    addressStreamController.close();
  }
}
