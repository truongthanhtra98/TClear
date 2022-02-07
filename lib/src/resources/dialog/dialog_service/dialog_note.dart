import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/detail_put_service.dart';
import 'package:sample_one/src/resources/payment/lien_he_va_thanh_toan.dart';

class DialogNote extends StatefulWidget {
  final DetailPutService detailPutService;

  DialogNote(this.detailPutService);
  @override
  _DialogNoteState createState() => _DialogNoteState();
}

class _DialogNoteState extends State<DialogNote> {
  var _noteTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 220,
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                  child: Center(
                  child: Text(
                  'Ghi chú cho người làm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              )),
              SizedBox(height: 20,),
              Expanded(
                flex: 5,
                  child: TextFormField(
                    controller: _noteTextController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      hintText: 'Bạn có muốn dặn dò gì thêm cho người làm không?'
                    ),
                  )),

              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(widget.detailPutService);

                      },
                      child: Text(
                        'Bỏ qua',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                       widget.detailPutService.note = _noteTextController.text;

                       Navigator.of(context).pop(widget.detailPutService);
                      },
                      child: Text(
                        'Đồng ý',
                        style: TextStyle(color: Colors.green, fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
