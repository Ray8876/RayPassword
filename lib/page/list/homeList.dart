import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:raypassword/globalData.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/add/addDir.dart';
import 'package:raypassword/page/add/addPassword.dart';
import 'package:raypassword/page/animation/FadeRoute.dart';
import 'package:raypassword/page/list/homeListOne.dart';
import 'package:raypassword/page/uniformStyle/uniDialog.dart';
import 'package:raypassword/popup/popup_menu.dart';
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

  PopupMenu menu = new PopupMenu();

  @override
  void initState() {
    super.initState();
    getList();
    PopupMenu.context = context;
    menu = PopupMenu(
      items: [
        MenuItem(
            title: '编辑',
            image: Icon(
              Icons.edit,
              color: Colors.white,
            )),
        MenuItem(
            title: '移动',
            image: Icon(
              Icons.drive_file_move_outline,
              color: Colors.white,
            )),
        MenuItem(
            title: '删除',
            image: Icon(
              Icons.delete_forever_rounded,
              color: Colors.white,
            )),
      ],
      onClickMenu: onClickMenu,
      stateChanged: stateChanged,
      onDismiss: onDismiss,
    );
  }

  void onClickMenu(MenuItemProvider item, dynamic id) {
    switch(item.menuTitle){
      case '编辑':
        editPassword(id);
        break;
      case '移动':
        movePassword(id);
        break;
      case '删除':
        confirmDelete(id);
        break;
    }
  }

  void onDismiss() {}

  void stateChanged(bool isShow) {}

  void popup(int id, GlobalKey globalKey) {
    menu.show(widgetKey: globalKey,data: id);
  }

  Future<void> confirmDelete(int id) async{
    Password psw = await db.getPassword(id);
    String tip;
    if(psw.isDir == 1){
      tip = "确定要删除？删除文件夹将删除所有文件夹内所有内容！！（不可恢复）";
    }else{
      tip = '确定要删除?（不可恢复！）';
    }

    UniDialog().show(context, tip, "取消", "确定").then((value) {
      if (value == 1) {
        db.deletePassword(id);
        setState(() {});
      }
    });
  }

  Future<void> movePassword(id) async{
    int isMove = await UniDialog().showChoseDir(context);
    if(isMove != null && isMove == 1){
      int newPos = GlobalData.instance.choseDir;
      Password psw = await db.getPassword(id);
      if(newPos == psw.id){
        Fluttertoast.showToast(
            msg: "不可以移动到自己里面",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepOrange,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      psw.fatherId = newPos;
      db.updatePassword(psw);
    }
  }

  void getLastDir() {
    db.getLastDirId(GlobalData.instance.nowPage).then((value) {
      GlobalData.instance.nowPage = value;
      getList();
    });
  }

  void getNextDir(int id) {
    GlobalData.instance.nowPage = id;
    getList();
  }

  Future<void> editPassword (int id) async{
    Password pp = await db.getPassword(id);
    if(pp.isDir == 1){
      Navigator.of(context).push(FadeRoute(AddDir(
        id: id,
      )));
    }
    else{
      Navigator.of(context).push(FadeRoute(AddPassword(
        id: id,
      )));
    }
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
      GlobalKey globalKey = new GlobalKey();
      Password temp = Password.fromMap(i);
      list.add(GestureDetector(
        onTap: () {
          if (temp.isDir == 1) {
            getNextDir(temp.id);
          } else {
            editPassword(temp.id);
          }
        },
        onLongPress: () {
          popup(temp.id, globalKey);
          //confirmDelete();
        },
        child: HomeListOne(
          key: globalKey,
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
