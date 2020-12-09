import 'package:path/path.dart';
import 'package:raypassword/model/password.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String passwordTable = 'passwordTable';
  final String columnId = 'id';
  final String isDir = 'isDir';
  final String title = 'title';
  final String username = 'username';
  final String password = 'password';
  final String remarks = 'remarks';
  final String fatherId = 'fatherId';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'RayPasswordDB.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $passwordTable('
            '$columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$isDir INTEGER, '
            '$title TEXT, '
            '$username TEXT, '
            '$password TEXT, '
            '$remarks TEXT, '
            '$fatherId INTEGER)'
    );
  }

  Future<void> printAllPassword() async {
    List list = await getAllPassword();
    for(var i in list){
      Password psw = Password.fromMap(i);
      print("id: " + psw.id.toString());
      print("isDir: " + psw.isDir.toString());
      print("title: " + psw.title);
      print("username: " + psw.username);
      print("password: " + psw.password);
      print("remarks: " + psw.remarks);
      print("fatherId: " + psw.fatherId.toString());
    }
  }

  Future<int> savePassword(Password psw) async {
    var dbClient = await db;
    var result = await dbClient.insert(passwordTable, psw.toMap());
    return result;
  }

  Future<List> getAllPassword() async {
    var dbClient = await db;
    var result = await dbClient.query(passwordTable,
        columns: [columnId, isDir, title, username, password ,remarks, fatherId]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $passwordTable'));
  }

  Future<bool> getSameDir(String _title,int _fatherId) async{
    var dbClient = await db;
    List<Map> result = await dbClient.query(passwordTable,
        columns: [columnId, isDir, title, username, password ,remarks, fatherId],
        where: "$isDir = 1 and $title = ? and $fatherId = ?",
        whereArgs: [_title, _fatherId]);
    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> getSamePassword(String _title,int _fatherId) async{
    var dbClient = await db;
    List<Map> result = await dbClient.query(passwordTable,
        columns: [columnId, isDir, title, username, password ,remarks, fatherId],
        where: "$isDir = 0 and $title = ? and $fatherId = ?",
        whereArgs: [_title, _fatherId]);
    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<Password> getPassword(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(passwordTable,
        columns: [columnId, isDir, title, username, password ,remarks, fatherId],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return Password.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteNote(String title) async {
    var dbClient = await db;
    return await dbClient.delete(passwordTable, where: '$title = ?', whereArgs: [title]);
  }

  Future<int> updateNote(Password psw) async {
    var dbClient = await db;
    return await dbClient.update(passwordTable, psw.toMap(), where: "$columnId = ?", whereArgs: [psw.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}