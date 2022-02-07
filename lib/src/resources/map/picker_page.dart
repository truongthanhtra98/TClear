import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_one/src/bloc/picker_bloc.dart';
import 'package:sample_one/src/resources/map/map_picker.dart';
import 'package:sample_one/src/resources/map/search_box.dart';
import 'package:sample_one/src/utils/colors.dart';

class MapPickerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vị trí làm việc', style: TextStyle(
            fontWeight: FontWeight.normal,
            color: white
        ),),
        iconTheme: IconThemeData(color: white),
        backgroundColor: orangeBackground,
      ),
      body: ChangeNotifierProvider<PickerBloc>(
        create: (_) => PickerBloc.getInstance(),
        child: MapPickerBody(),
      ),
    );
  }
}

class MapPickerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickerBloc>(
      builder: (context, bloc, child) => Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                MapPicker(bloc),
                SearchBox(bloc),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    //PickerBloc pickerBloc = Provider.of<PickerBloc>(context);
    return Container(
      height: 80,
      width: double.infinity,
      //color: Colors.blue[50],
      child: Consumer<PickerBloc>(builder: (context, bloc, child) =>
          FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.5,
            child:RaisedButton(
              color: GREEN,
              onPressed: () {
                Navigator.pop(context, bloc.currentLocation);
              },
              child: Text('Chọn vị trí này', style: TextStyle(color: white),),
            ),
          ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


