import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_one/src/data_models/content.dart';
import 'file:///D:/sample_one/lib/src/resources/login_signup/login_screen.dart';

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  List<Content> contents = [];
  bool _isContentsDataFormed = false;

  Future<List<Content>> loadCountriesJson() async {
    contents.clear();

    var value = await DefaultAssetBundle.of(context)
        .loadString("assets/json/experience.json");
    var countriesJson = json.decode(value);
    for (var content in countriesJson) {
      contents.add(Content.fromJson(content));
    }

    return contents;
  }

  Widget _buildContent(String title, String content){
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title != null ?
          Text(
            '$title',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),) : Padding(padding: EdgeInsets.all(0.0)),

          SizedBox(height: 5.0,),
          Text(
            '$content',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      if (contents.length < 6) {
        loadCountriesJson().whenComplete(() {
          setState(() => _isContentsDataFormed = true);
        });
      }
    });

    return  Container(
          child: _isContentsDataFormed ? getListContent() : Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),),
    );
  }

  Widget getListContent(){
    return
      ListView.builder(
          itemCount: contents == null ? 0 : contents.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildContent(contents[index].title, contents[index].content);
          }
      );
  }
}
