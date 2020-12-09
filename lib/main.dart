import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raypassword/page/add/addPage.dart';
import 'package:raypassword/page/animation/FadeRoute.dart';
import 'package:raypassword/page/list/homeList.dart';


void main() {
  runApp(MyApp());
  // if (Platform.isAndroid) {
  //   SystemUiOverlayStyle style = SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarIconBrightness: Brightness.dark
  //   );
  //   SystemChrome.setSystemUIOverlayStyle(style);
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RayPassword',
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    //单独设置某个页面的状态栏颜色
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Hero(tag: "addIcon",child: Icon(Icons.add,color: Colors.black,),),
          onPressed: () {
            /// 选择新增文件夹、新增记录
            Navigator.of(context).push(FadeRoute(AddPage()));
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.find_in_page_outlined,color: Colors.black,),
              onPressed: (){
                //todo: 过滤页面中包含该关键字的 “password”
              },
          )
        ],
        title: Text(
            "RayPassword",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: HomeList(),
      ),
    );
  }
}
