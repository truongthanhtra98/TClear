import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sample_one/src/bloc/picker_bloc.dart';

class MapPicker extends StatefulWidget {
  final PickerBloc bloc;
  MapPicker(this.bloc);

  @override
  State<MapPicker> createState() => MapPickerState();
}

class MapPickerState extends State<MapPicker> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _target;
  Position _currentPosition;


  Future<void> _initCurrentLocation() async {
    Position currentPosition;
    try {
      currentPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      setState(() => _currentPosition = currentPosition);
    } on PlatformException catch (e) {
      currentPosition = null;
    }

    if (!mounted) return;

    setState(() => _currentPosition = currentPosition);

    if (currentPosition != null)
      _target = LatLng(currentPosition.latitude, currentPosition.longitude);
      moveToCurrentLocation(
          LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  Future moveToCurrentLocation(LatLng currentLocation) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLocation, zoom: 16),
    ));
  }


  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
    widget.bloc.checkPermission();
    widget.bloc.locationController.stream.listen(
      (location) async {
        GoogleMapController mapController = await _controller.future;
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                location.lat,
                location.lng,
              ),
              zoom: 15.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _target != null ?
      Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _target,
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition newPosition) async {
             widget.bloc.setLocationByMovingMap(newPosition.target);
            },

          ),
          Center(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 36,
            ),
          ),
        ],
      ) : Center(child:  CircularProgressIndicator(backgroundColor: Colors.blue,)),
    );
  }
}
