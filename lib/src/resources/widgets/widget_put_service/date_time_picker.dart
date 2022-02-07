import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/date_picker.dart';
import 'package:sample_one/src/resources/widgets/widget_put_service/time_picker.dart';
import 'package:sample_one/src/utils/colors.dart';

class WorkTime extends StatefulWidget {
  final DetailPutService detailPutService;
  final DateTime dateTime;
  WorkTime(this.detailPutService, this.dateTime);
  @override
  _WorkTimeState createState() => _WorkTimeState();
}

class _WorkTimeState extends State<WorkTime> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'CHỌN NGÀY LÀM',
                  style: TextStyle(
                    color: grey,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  height: 40.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: grey, width: 1)),
                  child: Center(
                    child: datePicker(widget.detailPutService, widget.dateTime),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'CHỌN GIỜ LÀM',
                    style: TextStyle(
                      color: grey,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: grey, width: 1)),
                    child: Center(
                      child: timePicker(widget.detailPutService, widget.dateTime),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }


}
