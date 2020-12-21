import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raypassword/model/password.dart';
import 'package:raypassword/page/uniformStyle/uniDialog.dart';
import 'package:raypassword/sqlite/databaseHelper.dart';

class ExcelInOut {
  DatabaseHelper db = new DatabaseHelper();

  Future<void> writeExcel(BuildContext context) async {
    Excel excel = Excel.createExcel();
    var sheetObject = excel['Sheet1'];
    List<String> dataList = ["标题", "用户名", "密码", "备注"];
    sheetObject.insertRowIterables(dataList, 0);

    Directory saveDir = await getTemporaryDirectory();
    String savePath = join(saveDir.path, DateTime.now().toString() + ".xlsx");

    int count = 1;
    List allData = await db.getAllPassword();
    for (var i in allData) {
      Password psw = Password.fromMap(i);
      if (psw.isDir == 0) {
        List<String> tempList = [psw.title, psw.username, psw.password, psw.remarks];
        sheetObject.insertRowIterables(tempList, count++);
      }
    }

    ///保存文件
    var encodeData = await excel.encode();
    File(savePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(encodeData);

    // int openOrSave = await UniDialog().show(context, "直接打开还是保存到下载目录？", "直接打开", "保存到下载");
    // if(openOrSave == 0) {
      OpenFile.open(savePath);
      Fluttertoast.showToast(
          msg: savePath + "导出成功，正在打开",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    // }else{
    //
    // }

    return;
  }

  Future<void> readExcel(BuildContext context) async {
    ///选文件
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );

    ///不为空就读文件
    if (result != null) {
      File file = File(result.files.single.path);
      var bytes = File(file.path).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        int confirm = await UniDialog().show(context, '要导入"' + table + '"中的数据吗？', "取消", "确定");
        if (confirm == 1) {
          int isFirst = 1;
          for (var row in excel.tables[table].rows) {
            if (isFirst == 1) {
              isFirst = 0;
              continue;
            }
            Password psw = new Password(
              isDir: 0,
              title: row[0],
              username: row[1],
              password: row[2],
              remarks: row[3],
              fatherId: -1
            );
            db.savePassword(psw);
          }
          Fluttertoast.showToast(
              msg: "导入成功，请刷新查看",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } else {
      print("user canceled the picker!");
    }
    return;
  }
}
