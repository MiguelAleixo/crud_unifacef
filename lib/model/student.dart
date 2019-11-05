class Student {
  int _id;
  String _name;
  String _class;
 
  Student(this._name, this._class);
 
  Student.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._class = obj['class'];
  }
 
  int get id => _id;
  String get name => _name;
  String get class => _class;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) { map['id'] = _id; }
    map['name'] = _name;
    map['class'] = _class;
    return map;
  }
 
  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._class = map['class'];
  }
}