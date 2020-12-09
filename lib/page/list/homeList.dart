import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:raypassword/globalData.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/list/homeListOne.dart';
import 'package:raypassword/sqlite/databaseHelper.dart';

class HomeList extends StatefulWidget {
  HomeList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeList> {
  List<Widget> list = new List<Widget>();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getLastDir() {
    db.getLastDirId(GlobalData.instance.nowPage).then((value) {
      GlobalData.instance.nowPage = value;
      getList();
    });
  }

  void getNextDir(int id) {
    print("nextID:" + id.toString() );
    GlobalData.instance.nowPage = id;
    getList();
  }

  Future<void> getList() async {
    list.clear();
    List data = await db.getAllPasswordInDir(GlobalData.instance.nowPage);

    if (GlobalData.instance.nowPage != -1)
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      showChildOpacityTransition: false,
      springAnimationDurationInMilliseconds: 500,
      color: Colors.black54,
      onRefresh: getList,
      // refresh callback
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return list[index];
          }), // scroll view
    );
  }
}
