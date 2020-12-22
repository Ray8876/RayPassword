import 'package:flutter/material.dart';
import 'package:raypassword/page/list/choseDirList.dart';

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

  Future<int> showChoseDir(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("选择文件夹", style: new TextStyle(fontSize: 17.0)),
            content: ChoseDirList(),
            actions: <Widget>[
              new FlatButton(
                child: new Text("取消"),
                onPressed: (){
                  Navigator.of(context).pop(0);
                },
              ),
              new FlatButton(
                child: new Text("确定"),
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
