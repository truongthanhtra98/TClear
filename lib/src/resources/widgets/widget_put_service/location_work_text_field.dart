import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/location.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/resources/map/picker_page.dart';
import 'package:sample_one/src/utils/colors.dart';

class LocationWorkTextField extends StatefulWidget {

  final DetailPutService detailPutService;

  LocationWorkTextField({this.detailPutService});

  @override
  _LocationWorkTextFieldState createState() => _LocationWorkTextFieldState();
}

class _LocationWorkTextFieldState extends State<LocationWorkTextField> {
  String address = "";

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'NƠI LÀM VIỆC',
          style: TextStyle(
            color: grey,
            fontSize: 12.0,
          ),
        ),

        Container(
          height: 40.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: grey,
            border: Border.all(color: grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          child: RaisedButton(
            elevation: 0.0,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            color: white,
            onPressed: () async {
              Location location = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapPickerPage()),
              );
              if (location != null) {
                setState(() {
                  address = location.formattedAddress;
                  widget.detailPutService.locationWork = location;
                  bloc.event.add(PaymentEvent(widget.detailPutService));
                });
              }
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: BLACK,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.search,
                    color: GREEN,
                    size: 30.0,
                  ),
                ),
                ],
            ),
          ),
        ),
        Container(
          height: 15.0,
          child: StreamBuilder(
            //stream: widget.stream,
            builder: (context, snapshot) => Row(mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  snapshot.hasError ? snapshot.error : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: red,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
