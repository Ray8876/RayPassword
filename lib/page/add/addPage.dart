import 'package:flutter/material.dart';

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
              width: 200,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  /// 新增psw
                  Container(
                    height: 200,
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.attach_file_outlined,
                          size: 100,
                        ),
                        Container(
                          height: 50,
                          child: Text(
                            "新增记录",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 新增文件夹
                  Container(
                    height: 200,
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 100,
                        ),
                        Container(
                          height: 50,
                          child: Text(
                            "新建文件夹",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
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
