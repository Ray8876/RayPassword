import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeListOne extends StatefulWidget {
  final int id;
  final int isDir;
  final String title;
  final String username;
  final String password;
  final String remarks;
  final int fatherId;

  HomeListOne({
    Key key,
    this.title,
    this.username,
    this.password,
    this.remarks,
    this.isDir,
    this.id,
    this.fatherId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeListOneState();
  }
}

class _HomeListOneState extends State<HomeListOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            // borderRadius: BorderRadius.all(Radius.circular(5.0)),
            // border: new Border.all(width: 1, color: Colors.blueGrey[50]),
          ),
          child: widget.isDir == 1
              ? Row(
                  children: [
                    Icon(Icons.folder_open_rounded,size: 30,),
                    Text("   " + widget.title??"",
                    style: TextStyle(fontSize: 20),)
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          widget.remarks,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.username),
                        Text(widget.password),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
