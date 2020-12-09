import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raypassword/globalData.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/uniformStyle/uniButton.dart';
import 'package:raypassword/sqlite/databaseHelper.dart';

class AddPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword>{

  DatabaseHelper db = new DatabaseHelper();
  String newTitle = "";
  String newUsername = "";
  String newPassword = "";
  String newRemarks = "";


  FocusNode newTitleFN = new FocusNode();
  FocusNode newUsernameFN = new FocusNode();
  FocusNode newPasswordFN = new FocusNode();
  FocusNode newRemarksFN = new FocusNode();

  void savePassword(){
    newTitleFN.unfocus();
    newUsernameFN.unfocus();
    newPasswordFN.unfocus();
    newRemarksFN.unfocus();

    ///GlobalData 共享数据调用方法
    int faId = GlobalData.instance.nowPage;

    if((newTitle??"").isEmpty){
      Fluttertoast.showToast(
          msg: "标题不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    db.getSamePassword(newTitle,faId).then((v) {
      if(v){
        Fluttertoast.showToast(
            msg: "已存在相同标题的记录",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        db.savePassword(new Password(
          isDir: 0,
          title: newTitle,
          username: newUsername,
          password: newPassword,
          remarks: newRemarks,
          fatherId: faId,
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
              height: 380,
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
                            tag: "PswIcon",
                            child: Icon(Icons.attach_file_outlined,size: 30,color: Colors.black54,)
                        ),
                        Hero(tag: "PswText",
                            child: Text("新增记录",style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54
                            ),)),
                      ],
                    ),
                  ),

                  ///title
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        focusNode: newTitleFN,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.title_outlined),
                          hintText: '标题',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced:true,
                        maxLength: 16,
                        onChanged: (val) {
                          setState(() {
                            newTitle = val;
                          });
                        }
                    ),
                  ),

                  ///用户名
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        focusNode: newUsernameFN,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: '用户名',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced:true,
                        maxLength: 35,
                        onChanged: (val) {
                          setState(() {
                            newUsername = val;
                          });
                        }
                    ),
                  ),

                  ///密码
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        focusNode: newPasswordFN,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.keyboard),
                          hintText: '密码',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced:true,
                        maxLength: 35,
                        onChanged: (val) {
                          setState(() {
                            newPassword = val;
                          });
                        }
                    ),
                  ),

                  ///备注
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        focusNode: newRemarksFN,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.drive_file_rename_outline),
                          hintText: '备注',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced:true,
                        maxLength: 20,
                        onChanged: (val) {
                          setState(() {
                            newRemarks = val;
                          });
                        }
                    ),
                  ),

                  ///保存按钮
                  Center(
                    child: Container(
                      child: UniButton(
                        onPressed: savePassword,
                        text: "保存",
                      )
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