import 'package:flutter/material.dart';
import 'package:sample_one/src/my_firebase/cloud_firestore/firestore_infor_user.dart';
import 'package:sample_one/src/utils/colors.dart';

class DialogEvaluate extends StatefulWidget {
  final String idDetail;
  DialogEvaluate(this.idDetail);
  @override
  _DialogEvaluateState createState() => _DialogEvaluateState();
}

class _DialogEvaluateState extends State<DialogEvaluate> {
  TextEditingController _textCommentController = TextEditingController();
  int numberStar = 0;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Text('Đánh giá người làm dịch vụ', style: TextStyle(fontWeight: FontWeight.bold),),
            Container(
              child: Row(
                children: [

                  Expanded(
                    child: IconButton(
                        icon: numberStar > 0
                            ? Icon(
                          Icons.star,
                          color: orangeBackground,
                        )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            numberStar = 1;
                          });
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: numberStar > 1
                            ? Icon(
                          Icons.star,
                          color: orangeBackground,
                        )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            numberStar = 2;
                          });
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: numberStar > 2
                            ? Icon(
                          Icons.star,
                          color: orangeBackground,
                        )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            numberStar = 3;
                          });
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: numberStar > 3
                            ? Icon(
                          Icons.star,
                          color: orangeBackground,
                        )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            numberStar = 4;
                          });
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: numberStar > 4
                            ? Icon(
                          Icons.star,
                          color: orangeBackground,
                        )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            numberStar = 5;
                          });
                        }),
                  ),
                ],
              ),
            ),

            numberStar != 0 ?
            TextFormField(
              controller: _textCommentController,
              maxLines: 5,
              //minLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập lý do bạn đánh giá như thế',
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              ),
            ) : SizedBox(),

          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      actions: [
        numberStar != 0 ? RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: GREEN,
            child: Text('Đánh giá'),
            onPressed: (){
              String comment = _textCommentController.text;
              Evaluate.updateEvaluate(widget.idDetail, numberStar, comment);
              Navigator.of(context).pop();
            }) : SizedBox(),
      ],
    );
  }
}
