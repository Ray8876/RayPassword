import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raypassword/globalData.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/add/randomPassword.dart';
import 'package:raypassword/page/animation/FadeRoute.dart';
import 'package:raypassword/page/uniformStyle/uniButton.dart';
import 'package:raypassword/sqlite/databaseHelper.dart';

class AddPassword extends StatefulWidget {
  final int id;

  const AddPassword({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  DatabaseHelper db = new DatabaseHelper();
  bool isShowPassword = true;
  String newTitle = "";
  String newUsername = "";
  String newPassword = "";
  String newRemarks = "";

  FocusNode newTitleFN = new FocusNode();
  FocusNode newUsernameFN = new FocusNode();
  FocusNode newPasswordFN = new FocusNode();
  FocusNode newRemarksFN = new FocusNode();

  TextEditingController newTitleCot = new TextEditingController();
  TextEditingController newUsernameCot = new TextEditingController();
  TextEditingController newPasswordCot = new TextEditingController();
  TextEditingController newRemarksCot = new TextEditingController();

  void savePassword() {
    newTitleFN.unfocus();
    newUsernameFN.unfocus();
    newPasswordFN.unfocus();
    newRemarksFN.unfocus();

    ///GlobalData 共享数据调用方法
    int faId = GlobalData.instance.nowPage;

    if ((newTitle ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: "标题不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (widget.id == null) {
    } else {}
    db.getSamePassword(widget.id ?? -1, newTitle, faId).then((v) {
      if (v) {
        Fluttertoast.showToast(
            msg: "已存在相同标题的记录",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        if (widget.id == null) {
          db
              .savePassword(Password(
            isDir: 0,
            title: newTitle,
            username: newUsername,
            password: newPassword,
            remarks: newRemarks,
            fatherId: faId,
          ))
              .then((value) {
            Fluttertoast.showToast(
                msg: "添加成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green[700],
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else {
          db
              .updatePassword(Password(
            id: widget.id,
            isDir: 0,
            title: newTitle,
            username: newUsername,
            password: newPassword,
            remarks: newRemarks,
            fatherId: faId,
          ))
              .then((value) {
            Fluttertoast.showToast(
                msg: "修改成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green[700],
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      print("add page id:" + widget.id.toString());
      db.getPassword(widget.id).then((psw) {
        newTitle = psw.title;
        newUsername = psw.username;
        newPassword = psw.password;
        newRemarks = psw.remarks;

        newTitleCot.text = newTitle;
        newUsernameCot.text = newUsername;
        newPasswordCot.text = newPassword;
        newRemarksCot.text = newRemarks;

        setState(() {});
      });
    }
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
                        Row(
                          children: [
                            Hero(
                                tag: "PswIcon",
                                child: Icon(
                                  Icons.attach_file_outlined,
                                  size: 30,
                                  color: Colors.black54,
                                )),
                            Hero(
                                tag: "PswText",
                                child: Text(
                                  "新增记录",
                                  style: TextStyle(fontSize: 20, color: Colors.black54),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///title
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        controller: newTitleCot,
                        focusNode: newTitleFN,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.title_outlined),
                          hintText: '标题',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced: true,
                        maxLength: 16,
                        onChanged: (val) {
                          setState(() {
                            newTitle = val;
                          });
                        }),
                  ),

                  ///用户名
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        focusNode: newUsernameFN,
                        controller: newUsernameCot,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: '用户名',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced: true,
                        maxLength: 35,
                        onChanged: (val) {
                          setState(() {
                            newUsername = val;
                          });
                        }),
                  ),

                  ///密码
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Stack(
                      children: [
                        TextField(
                            obscureText: isShowPassword,
                            focusNode: newPasswordFN,
                            controller: newPasswordCot,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.keyboard),
                              hintText: '密码',
                              contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            ),
                            maxLengthEnforced: true,
                            maxLength: 35,
                            onChanged: (val) {
                              setState(() {
                                newPassword = val;
                              });
                            }),
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(FadeRoute(RandomPassword())).then((rand) {
                                    print("rand back " + rand.toString());
                                    if (rand != null) {
                                      newPassword = rand;
                                      newPasswordCot.text = rand;
                                    }
                                  });
                                },
                                child: Hero(
                                  tag: "randIcon",
                                  child: Icon(Icons.track_changes_sharp),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                child: isShowPassword
                                    ? Icon(Icons.remove_red_eye_outlined)
                                    : Icon(Icons.remove_red_eye_rounded),
                                onTap: () {
                                  isShowPassword = !isShowPassword;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  ///备注
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                        focusNode: newRemarksFN,
                        controller: newRemarksCot,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.drive_file_rename_outline),
                          hintText: '备注',
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        maxLengthEnforced: true,
                        maxLength: 20,
                        onChanged: (val) {
                          setState(() {
                            newRemarks = val;
                          });
                        }),
                  ),

                  ///保存按钮
                  Center(
                    child: Container(
                        child: UniButton(
                      onPressed: savePassword,
                      text: "保存",
                    )),
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
