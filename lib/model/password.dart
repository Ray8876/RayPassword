class Password {

  int id;
  int isDir;
  String title;
  String username;
  String password;
  String remarks;

  int fatherId;


  Password({this.id,this.isDir,this.title,this.username,this.password,this.remarks,this.fatherId});

  Password.map(dynamic obj){
    this.id = obj['id'];
    this.isDir = obj['isDir'];
    this.title = obj['title'];
    this.username = obj['username'];
    this.password = obj['password'];
    this.remarks = obj['remarks'];
    this.fatherId = obj['fatherId'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['isDir'] = isDir;
    map['title'] = title;
    map['username'] = username;
    map['password'] = password;
    map['remarks'] = remarks;
    map['fatherId'] = fatherId;
    return map;
  }

  Password.fromMap(Map<String, dynamic> map) {
    this.id = map['id']??-1;
    this.isDir = map['isDir']??-1;
    this.title = map['title']??"";
    this.username = map['username']??"";
    this.password = map['password']??"";
    this.remarks = map['remarks']??"";
    this.fatherId = map['fatherId']??-1;
  }
}