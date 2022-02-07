import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/payment_bloc.dart';
import 'package:sample_one/src/data_models/abtraction_detail_put_service/model_service_3.dart';
import 'package:sample_one/src/event/payment_event.dart';
import 'package:sample_one/src/utils/colors.dart';

class MySlider extends StatefulWidget {
  final ModelService3 modelService3;

  MySlider(this.modelService3);
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double rating = 2;
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<PaymentBloc>(context);
    return Scaffold(
      body: Container(
        color: white,
        child: Row(
          children: <Widget>[
            Text("Số người ăn(${rating.floor()})"),
            Expanded(
              child: Slider(
                value: rating,
                onChanged: (newRating) {
                  setState(() {
                    rating = newRating;
                    widget.modelService3.numberPersonEat = rating.floor();
                    bloc.event.add(PaymentEvent(widget.modelService3));
                  });
                },
                min: 2,
                max: 8,
                divisions: 6,
                label: "${rating.floor()}",
                activeColor: orangeBackground,
                inactiveColor: white,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
