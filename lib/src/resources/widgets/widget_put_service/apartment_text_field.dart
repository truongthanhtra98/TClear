import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/data_models/apartment_model.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/resources/dialog/dialog_service/dialog_apartment.dart';

class ApartmentTextField extends StatefulWidget {
  final Stream stream;
  final DetailPutService detailPutService;

  ApartmentTextField({this.stream, this.detailPutService});

  @override
  _ApartmentTextFieldState createState() => _ApartmentTextFieldState();
}

class _ApartmentTextFieldState extends State<ApartmentTextField> {
  String _apartmentNumber = "";
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'SỐ NHÀ/ CĂN HỘ',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Container(
          height: 40.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          child: RaisedButton(
            elevation: 0.0,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            color: Colors.white,

            onPressed: () async {
              ApartmentModel apartmentModel = await showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return DialogApartment();
                  }
              );

              if(apartmentModel != null){
                setState(() {
                  _apartmentNumber = apartmentModel.apartmentNumber;
                  widget.detailPutService.apartment = apartmentModel;
                  bloc.event.add(PaymentEvent(widget.detailPutService));
                });
              }
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _apartmentNumber,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 15.0,
          child: StreamBuilder(
            stream: widget.stream,
            builder: (context, snapshot) => Row(mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  snapshot.hasError ? snapshot.error : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
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
