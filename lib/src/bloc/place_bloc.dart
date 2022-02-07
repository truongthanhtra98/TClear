import 'dart:async';

import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/valicators/place_service.dart';

class PlaceBloc {
  var _placeController = StreamController();
  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword, Location location) {
    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword, location).then((rs) {
      _placeController.sink.add(rs);
    }).catchError(() {
     _placeController.sink.add("stop");
    });
  }

  void dispose() {
    _placeController.close();
  }
}