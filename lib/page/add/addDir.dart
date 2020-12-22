import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raypassword/globalData.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/uniformStyle/uniButton.dart';
import 'package:raypassword/sqlite/databaseHelper.dart';

class AddDir extends StatefulWidget {
  final int id;
  const AddDir({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddDirState();
  }
}

class _AddDirState extends State<AddDir> {

  Password oldPsw;

  DatabaseHelper db = new DatabaseHelper();
  String dirName = "";
  TextEditingController dirNameController = new TextEditingController();
  FocusNode dirNameFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    if(widget.id != null){
      db.getPassword(widget.id).then((value){
        oldPsw = value;
        dirNameController.text = value.title;
        dirName = value.title;
        setState(() { });
      });
    }
  }

  void saveDir(){
    dirNameFocusNode.unfocus();
    if((dirName??"").isEmpty){
      Fluttertoast.showToast(
          msg: "文件夹名不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    db.getSameDir(dirName,GlobalData.instance.nowPage).then((v) {
      if(v){
        Fluttertoast.showToast(
            msg: "已存在同名文件夹",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        if(widget.id != null){
          db.updatePassword(new Password(
            id: oldPsw.id,
            title: dirName,
            fatherId: GlobalData.instance.nowPage,
          ));
        }else{
          db.savePassword(new Password(
            isDir: 1,
            title: dirName,
            fatherId: GlobalData.instance.nowPage,
          )).then((value) {
            Fluttertoast.showToast(
                msg: "添加成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green[700],
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Opacity(
              opacity: 0.8,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black26,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  ///"dir"标题
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),

                    child: Row(
                      children: [
                        Hero(
                            tag: "dirIcon",
                            child: Icon(Icons.folder_outlined,size: 30,color: Colors.black54,)
                        ),
                        Hero(tag: "dirText",
                            child: Text("新增文件夹",style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54
                        ),)),
                      ],
                    ),
                  ),

                  ///输入框
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                    child: TextField(
                      controller: dirNameController,
                      focusNode: dirNameFocusNode,
                        decoration: const InputDecoration(
                          hintText: '文件夹名',
                          contentPadding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        ),
                        maxLengthEnforced:true,
                        maxLength: 16,
                        onChanged: (val) {
                          setState(() {
                            dirName = val;
                          });
                        }
                    ),
                  ),

                  ///保存文件夹
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: UniButton(onPressed: saveDir,text: "保存",)
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
