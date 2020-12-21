import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raypassword/excelInOut.dart';
import 'package:raypassword/page/uniformStyle/uniButton.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingState();

}

class _SettingState extends State<Setting>{
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
                  ///"setting"标题
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),

                    child: Row(
                      children: [
                        Hero(
                            tag: "settingIcon",
                            child: Icon(Icons.settings,size: 30,color: Colors.black54,)
                        ),
                        Text("设置",style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54
                            ),),
                      ],
                    ),
                  ),

                  Container(
                    height: 20,
                  ),

                  ///导入导出
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UniButton(
                          text: "导入",
                          onPressed: (){

                            ExcelInOut().readExcel(context);
                            setState(() {
                            });
                          },
                        ),
                        SizedBox(width: 20,),
                        UniButton(
                          text: "导出",
                          onPressed: (){
                            ExcelInOut().writeExcel(context);
                          },
                        )
                      ],
                    ),
                  ),

                  Center(
                    child: Text("暂只支持记录导入导出（不包含文件夹）"),
                  ),
                  ///关于
                  Container(
                    padding: EdgeInsets.only(top: 110),
                    child: Container(
                      child: Column(
                        children: [
                          Text("版本： 0.0.1 beta",style: TextStyle(fontSize: 18),),
                          Text("RayPassword",style: TextStyle(fontSize: 14),),
                          Text("Copyright 2020-现在, github.com/ray8876",style: TextStyle(fontSize: 11),),
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