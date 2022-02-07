import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/utils/data_holder.dart';

class timePicker extends StatefulWidget {
  DetailPutService detailPutService;
  DateTime dateTime;
  timePicker(this.detailPutService, this.dateTime);
  @override
  _timePickerState createState() => _timePickerState();
}

class _timePickerState extends State<timePicker> {
  String time = "TIME";

  TimeOfDay _time;

  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.fromDateTime(widget.dateTime);
    time = '${_time.hour}:${_time.minute}';
    widget.detailPutService.hour = time;
  }

  @override
  Future<Null> selectTime(PaymentBloc bloc, BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      print("Time selected : ${_time.toString()}");

      setState(() {
        _time = picked;
        time = _time.format(context).toString();
        widget.detailPutService.hour = time;
        bloc.event.add(PaymentEvent(widget.detailPutService));
      });
    }
  }

  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return GestureDetector(
      child: new Text(
        time,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        selectTime(bloc, context);
      },
    );
  }
}