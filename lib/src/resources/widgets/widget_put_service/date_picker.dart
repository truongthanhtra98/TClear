import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class datePicker extends StatefulWidget {
  DetailPutService detailPutService;
  DateTime dateTime;
  datePicker(this.detailPutService, this.dateTime);

  @override
  _datePickerState createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {
  String date;
  DateTime _date;

  @override
  void initState() {
    super.initState();
    if(widget.dateTime.isAfter(DateTime.now())){
      _date = widget.dateTime;
    }else{
      _date = DateTime.now();
    }
    date = formatter.format(_date);
    widget.detailPutService.day = _date;
  }

  @override
  Future<Null> selectDate(PaymentBloc bloc, BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime.now(),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );
    if (picked != null && picked != _date) {
      print("Date selected : ${_date.toString()}");

      setState(() {
        _date = picked;
        date = formatter.format(picked);
        widget.detailPutService.day = _date;
        bloc.event.add(PaymentEvent(widget.detailPutService));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return GestureDetector(
      child: new Text(
        date,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        selectDate(bloc, context);
      },
    );
  }
}
