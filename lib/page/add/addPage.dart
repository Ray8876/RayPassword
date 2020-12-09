import 'package:flutter/material.dart';
import 'package:raypassword/page/add/addDir.dart';
import 'package:raypassword/page/add/addPassword.dart';
import 'package:raypassword/page/animation/FadeRoute.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPageState();
  }
}

class _AddPageState extends State<AddPage> {
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
                  ///"add"标题
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Row(
                      children: [
                        Hero(
                            tag: "addIcon",
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black54,
                            )),
                        Text(
                          "新增",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        )
                      ],
                    ),
                  ),

                  /// 新增psw
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(FadeRoute(AddPassword()));
                    },
                    child: Container(
                      height: 160,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children: [
                          Hero(
                              tag: "PswIcon",
                              child: Icon(
                                Icons.attach_file_outlined,
                                size: 100,
                              )),
                          Container(
                            height: 30,
                            child: Hero(
                              tag: "PswText",
                              child: Text(
                                "新增记录",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 新增文件夹
                  GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.of(context).push(FadeRoute(AddDir()));
                    },
                    child: Container(
                      height: 180,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children: [
                          Hero(
                              tag: "dirIcon",
                              child: Icon(
                                Icons.folder_outlined,
                                size: 100,
                              )),
                          Container(
                            height: 30,
                            child: Hero(
                              tag: "dirText",
                              child: Text(
                                "新建文件夹",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
