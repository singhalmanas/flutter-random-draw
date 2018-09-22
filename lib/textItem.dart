import 'package:flutter/material.dart';

class TextItem extends StatelessWidget{
  
  TextItem({this.text,this.isDrawn});
  final String text;
  bool isDrawn;
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical:10.0),
      child: new Text(text,
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
      );
  }
  
} 