import 'package:flutter/material.dart';
import 'package:raypassword/page/list/homeListOne.dart';

class HomeList extends StatefulWidget {
  HomeList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }

}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeListOne(
          title: "123",
          username: "admin",
          password: "psw",
          remarks: "主",
        ),
        HomeListOne(
          title: "456",
          username: "admin2",
          password: "psw1",
          remarks: "副",
        ),
      ],
    );
  }
}