import 'package:flutter/material.dart';

class UniDialog {

  Future<int> show(BuildContext context,String title,String text1,String text2){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(title, style: new TextStyle(fontSize: 17.0)),
            actions: <Widget>[
              new FlatButton(
                child: new Text(text1),
                onPressed: (){
                  Navigator.of(context).pop(0);
                },
              ),
              new FlatButton(
                child: new Text(text2),
                onPressed: (){
                  Navigator.of(context).pop(1);
                },
              )
            ],
          );
        }
    );
  }
}
