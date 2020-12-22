class GlobalData {
  int nowPage = -1;
  int choseDir = -1;
  factory GlobalData() => _getInstance();
  static GlobalData get instance => _getInstance();
  static GlobalData _instance;
  GlobalData._internal();
  static GlobalData _getInstance() {
    if (_instance == null) {
      _instance = new GlobalData._internal();
    }
    return _instance;
  }
}