import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_1.dart';
import 'package:sample_one/src/utils/colors.dart';

class RepeatSwitch extends StatefulWidget {
  final ModelService1 detailPutService;

  RepeatSwitch(this.detailPutService);
  @override
  _RepeatSwitchState createState() => _RepeatSwitchState();
}

class _RepeatSwitchState extends State<RepeatSwitch> {
  bool _repeat = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lặp lại hằng tuần',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: GestureDetector(
                    child: Text(
                      "Nghĩa là gì?",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DialogRepeatExplain();
                          });
                    },
                  ),
                )
              ],
            ),
            Spacer(),
            Switch(
              activeColor: orangeBackground,
              value: _repeat,
              onChanged: (value) {
                setState(() {
                  _repeat = value;
                  //widget.detailPutService.repeat = _repeat;
                });
              },
            ),
          ],
        ),
        _repeat ? _buildChooseDay() : SizedBox(),
      ],
    );
  }

  bool cn = false,
      t2 = false,
      t3 = false,
      t4 = false,
      t5 = false,
      t6 = false,
      t7 = false;
  Widget _buildChooseDay() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFF1F1F1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Center(
                child: Text(
                  'CN',
                  style: TextStyle(
                      color: cn ? Colors.green : Colors.black45, fontSize: 15),
                ),
              ),
              onTap: () {
                setState(() {
                  cn = !cn;
                });
                widget.detailPutService.mapRepeat['CN'] = cn;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Center(
                child: Text(
                  'T2',
                  style: TextStyle(
                      color: t2 ? Colors.green : Colors.black45, fontSize: 15),
                ),
              ),
              onTap: () {
                setState(() {
                  t2 = !t2;
                });
                widget.detailPutService.mapRepeat['T2'] = t2;
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                child: Center(
                    child: Text(
                  'T3',
                  style: TextStyle(
                      color: t3 ? Colors.green : Colors.black45, fontSize: 15),
                )),
                onTap: () {
                  setState(() {
                    t3 = !t3;
                  });
                  widget.detailPutService.mapRepeat['T3'] = t3;
                },
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                child: Center(
                    child: Text(
                  'T4',
                  style: TextStyle(
                      color: t4 ? Colors.green : Colors.black45, fontSize: 15),
                )),
                onTap: () {
                  setState(() {
                    t4 = !t4;
                  });
                  widget.detailPutService.mapRepeat['T4'] = t4;
                },
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                child: Center(
                    child: Text(
                  'T5',
                  style: TextStyle(
                      color: t5 ? Colors.green : Colors.black45, fontSize: 15),
                )),
                onTap: () {
                  setState(() {
                    t5 = !t5;
                  });
                  widget.detailPutService.mapRepeat['T5'] = t5;
                },
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                child: Center(
                    child: Text(
                  'T6',
                  style: TextStyle(
                      color: t6 ? Colors.green : Colors.black45, fontSize: 15),
                )),
                onTap: () {
                  setState(() {
                    t6 = !t6;
                  });
                  widget.detailPutService.mapRepeat['T6'] = t6;
                },
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                child: Center(
                    child: Text(
                  'T7',
                  style: TextStyle(
                    color: t7 ? Colors.green : Colors.black45,
                    fontSize: 15,
                  ),
                )),
                onTap: () {
                  setState(() {
                    t7 = !t7;
                  });
                  widget.detailPutService.mapRepeat['T7'] = t7;
                },
              )),
        ],
      ),
    );
  }
}

class DialogRepeatExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Lặp lại hàng tuần là gì?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
      content: Text(
        'Tính năng này dành cho khách hàng có nhu cầu DỌN DẸP NHÀ CỐ ĐỊNH vào các ngày trong tuần.\n\n'
        'Hệ thống sẽ tự động đăng việc vào các ngày bạn đã chọn. Bạn có thể chủ động thay đổi, dừng hoặc tiếp tục lịch lặp lại tại "Việc đã đăng" -> "Lặp lại"\n\n'
        'Đối với công việc đã được đăng lên, bạn vui lòng thao tác trực tiếp trên từng công việc.',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đồng ý',
            style: TextStyle(color: Colors.green, fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
