import 'package:flutter/material.dart';
import 'package:crud_unifacef/model/student.dart';
import 'package:crud_unifacef/util/database_helper.dart';

class StudentScreen extends StatefulWidget {
  final Student student;
  StudentScreen(this.student);

  @override
  State<StatefulWidget> createState() => new _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _nameController;
  TextEditingController _classeController;

  @override
  void initState() {
  super.initState();

    _nameController = new TextEditingController(text: widget.student.name);
    _classeController = new TextEditingController(text: widget.student.classe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _classeController,
              decoration: InputDecoration(labelText: 'Classe'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.student.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.student.id != null) {
                  db.updateStudent(Student.fromMap({
                    'id': widget.student.id,
                    'name': _nameController.text,
                    'classe': _classeController.text
                  })).then((_) { Navigator.pop(context, 'update'); });
                } else {
                  db.saveStudent(Student(_nameController.text, _classeController.text)).then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
