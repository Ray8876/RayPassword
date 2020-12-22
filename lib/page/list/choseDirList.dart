import 'package:flutter/material.dart';
import 'package:raypassword/globalData.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/list/homeListOne.dart';
import 'package:raypassword/sqlite/databaseHelper.dart';


class ChoseDirList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoseDirListState();
}

class _ChoseDirListState extends State<ChoseDirList> {

  @override
  void initState() {
    super.initState();
    getList();
  }

  List<Widget> list = new List<Widget>();
  DatabaseHelper db = new DatabaseHelper();

  void getLastDir() {
    db.getLastDirId(GlobalData.instance.choseDir).then((value) {
      GlobalData.instance.choseDir = value;
      getList();
    });
  }
  void getNextDir(int id) {
    GlobalData.instance.choseDir = id;
    getList();
  }

  Future<void> getList() async {
    list.clear();
    List data = await db.getAllPasswordInDir(GlobalData.instance.choseDir);

    if (GlobalData.instance.choseDir != -1)
      list.add(GestureDetector(
        onTap: () {
          getLastDir();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                ),
                child: Row(
                  children: [Icon(Icons.upload_rounded), Text("返回上一层")],
                )),
          ),
        ),
      ));

    for (var i in data) {
      Password temp = Password.fromMap(i);
      if(temp.isDir == 0) continue;
      list.add(GestureDetector(
        onTap: (){
          if (temp.isDir == 1){
            getNextDir(temp.id);
          }
        },
        child: HomeListOne(
          id: temp.id,
          isDir: temp.isDir,
          title: temp.title,
          username: temp.username,
          password: temp.password,
          remarks: temp.remarks,
          fatherId: temp.fatherId,
        ),
      ));
    }

    if(list.isEmpty) {
      list.add(Center(child: Text("未找到文件夹"),));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        });
  }
}
