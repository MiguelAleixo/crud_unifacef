class Student {
  int _id;
  String _name;
  String _classe;
  String _age;

  Student(this._name, this._classe, this._age);

  Student.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._classe = obj['classe'];
    this._age = obj['age'];
  }

  int get id => _id;
  String get name => _name;
  String get classe => _classe;
  String get age => _age;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['classe'] = _classe;
    map['age'] = _age;
    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._classe = map['classe'];
    this._age = map['age'];
  }
}
