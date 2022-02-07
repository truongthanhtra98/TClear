import 'package:flutter/material.dart';
import 'package:sample_one/src/bloc/picker_bloc.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/resources/map/ride_picker_page.dart';
import 'package:sample_one/src/utils/colors.dart';

class SearchBox extends StatefulWidget {
  final PickerBloc bloc;
  SearchBox(this.bloc);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  var _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: StreamBuilder<String>(
          stream: widget.bloc.getStreamAddress,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              _addressController.text = snapshot.data.toString();
            }
            return TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 16.0,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF757575),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                  fillColor: white,
                  filled: true),
              readOnly: true,
              onTap: () async{
                Location location = await
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => RidePickerPage(widget.bloc.currentLocation)));

                String address = "";

                if(location != null) {
                  address = "${location.name}, ${location.formattedAddress}".replaceAll('<b' + 'r/>', ', ');
                  widget.bloc.locationSelected(location);
                  //widget.bloc.setLocationByMovingMap(LatLng(location.lat, location.lng));
                  Future.delayed(Duration(seconds: 5), (){
                    if(location.name != null){
                      print(address);
                      widget.bloc.addressStreamController.sink.add(address);
                      widget.bloc.currentLocation = Location(lat: location.lat, lng: location.lng, formattedAddress: address);
                    }
                  });
                }
              },
            );
          }
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
