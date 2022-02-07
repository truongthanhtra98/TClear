import 'package:flutter/material.dart';
import 'package:sample_one/src/bloc/place_bloc.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/valicators/place_service.dart';

class RidePickerPage extends StatefulWidget {
  final Location location;

  RidePickerPage(this.location);
  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  TextEditingController _searchController = TextEditingController();
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _searchController.addListener(() {
      final text = _searchController.text;
      _searchController.value = _searchController.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    placeBloc.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: Container(
            height: 42.0,
            child: TextField(
              controller: _searchController,
              onChanged: ((value) {
                setState(() {
                  _searchController.text = value;
                  placeBloc.searchPlace(_searchController.text, widget.location);
                });
              }),
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
                suffixIcon: IconButton(
                    icon: Icon(Icons.close, color: Color(0xFF757575)),
                    onPressed: () {
                      _searchController.text = "";
                    }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                fillColor: Color(0xFFEEEEEE),
                filled: true,
              ),
              style: TextStyle(fontSize: 16, color: Color(0xff323643)),
            ),
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.toString());
                      if (snapshot.data == "start") {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<Location> places = snapshot.data;
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                              ),
                              title: Text(
                                places.elementAt(index).name == null
                                    ? ''
                                    : places.elementAt(index).name,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                places.elementAt(index).formattedAddress == null
                                    ? ''
                                    : places.elementAt(index).formattedAddress.replaceAll('<b' + 'r/>', ', '),
                              ),
                              onTap: () {
                                Navigator.of(context).pop(places.elementAt(index));
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Color(0xfff5f5f5),
                          ),
                          itemCount: places.length);
                    } else {
                      return Container();
                    }
                  }),
            ),

          ],
        ),
      ),
    );
  }
}
