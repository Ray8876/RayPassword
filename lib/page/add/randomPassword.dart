import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raypassword/page/uniformStyle/uniButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RandomPasswordState();
  }
}

class _RandomPasswordState extends State<RandomPassword> {
  SharedPreferences share;
  bool is_a = true;
  bool is_A = true;
  bool is_0 = true;
  bool is_symb = true;
  double passwordLen = 1;

  ///symbol
  String symb = "";
  TextEditingController symbCon = new TextEditingController();
  bool editAble = true;
  FocusNode symbFN = new FocusNode();

  ///显示生成的密码
  String newPsw = "";
  TextEditingController newPswCon = new TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    share = await SharedPreferences.getInstance();
    is_a = share.getBool('is_a') ?? true;
    is_A = share.getBool('is_A') ?? true;
    is_0 = share.getBool('is_A') ?? true;
    is_symb = share.getBool('is_symb') ?? true;
    symb = share.getString('symb') ?? "!@#%^&*()+-";
    symbCon.text = symb;

    passwordLen = (share.getInt('passwordLen') ?? 10).toDouble();
    setState(() {});
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
              height: 410,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  ///生成随机密码
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Row(
                      children: [
                        Hero(
                            tag: "randIcon",
                            child: Icon(
                              Icons.track_changes_sharp,
                              size: 30,
                              color: Colors.black54,
                            )),
                        Text(
                          "生成随机密码",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        )
                      ],
                    ),
                  ),

                  ///请选择条件
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Row(
                      children: [Text("(请选择条件)")],
                    ),
                  ),

                  ///a-z + A-Z
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: is_a,
                              onChanged: (bool value) {
                                is_a = value;
                                share.setBool("is_a", is_a).then((value) {
                                  //print(share.getBool("is_a").toString());
                                  setState(() {});
                                });
                              },
                            ),
                            Text(
                              "a - z",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: is_A,
                              onChanged: (bool value) {
                                is_A = value;
                                share.setBool("is_A", is_A).then((value) {
                                  //print(share.getBool("is_A").toString());
                                  setState(() {});
                                });
                              },
                            ),
                            Text(
                              "A - Z",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // ///A-Z
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  //   child: ,
                  // ),

                  ///0 - 9
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: is_0,
                          onChanged: (bool value) {
                            is_0 = value;
                            share.setBool("is_0", is_0).then((value) {
                              //print(share.getBool("is_0").toString());
                              setState(() {});
                            });
                          },
                        ),
                        Text(
                          "0 - 9",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),

                  ///符号
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: is_symb,
                          onChanged: (bool value) {
                            is_symb = value;
                            share.setBool("is_symb", is_symb).then((value) {
                              //print(share.getBool("is_symb").toString());
                              setState(() {});
                            });
                          },
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 165,
                              child: TextField(
                                focusNode: symbFN,
                                readOnly: editAble,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: '其他符号',
                                  // border: InputBorder.none,
                                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                                controller: symbCon,
                                onChanged: (v) {
                                  share.setString("symb", v.trim());
                                  symb = v;
                                  setState(() {});
                                },
                              ),
                            ),
                            Container(
                              width: 220,
                              padding: EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      editAble = !editAble;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      symb = "!@#%^&*()+-";
                                      symbCon.text = symb;
                                      share.setString("symb", symb);
                                    },
                                    child: Icon(Icons.settings_backup_restore),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  ///密码长度
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 40
                    ),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Slider(
                      min: 1.0,
                      max: 28.0,
                      divisions: 100,
                      label: "长度：" + passwordLen.toInt().toString(),
                      value: passwordLen,
                      onChanged: (v){
                        passwordLen = v.toInt().toDouble();
                        share.setInt("passwordLen", passwordLen.toInt());
                        setState(() {});
                      },

                    ),
                  ),


                  ///显示
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: newPswCon,
                        maxLines: 1,
                      ),
                    ),
                  ),

                  ///生成
                  Center(
                    child: Container(
                      child: GestureDetector(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh_rounded,color: Colors.blue,),
                              Text("生成",style: TextStyle(
                                color: Colors.blue
                              ),)
                            ],
                          ),
                        ),
                        onTap: () {
                          /// 生成密码的算法
                          String allChar = "";
                          if(is_a){
                            allChar = allChar + "abcdefghijklmnopqrstuvwxyz";
                          }
                          if(is_A){
                            allChar = allChar + "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                          }
                          if(is_0){
                            allChar = allChar + "0123456789";
                          }
                          if(is_symb){
                            allChar = allChar + symb.trim();
                          }

                          if(allChar.length < 1){
                            Fluttertoast.showToast(
                                msg: "必须有数据才能生成",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.deepOrangeAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                          newPsw = "";
                          Random random = new Random();
                          for(int i = 0 ; i < passwordLen ; ++i){
                            newPsw = newPsw + allChar[random.nextInt(allChar.length)];
                            newPswCon.text = newPsw;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UniButton(
                            text: "取消",
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          UniButton(
                            text: "应用",
                            onPressed: (){
                              Navigator.pop(context,newPsw);
                            },
                          ),
                        ],
                      ),
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
