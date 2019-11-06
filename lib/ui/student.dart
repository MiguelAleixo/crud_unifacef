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
  TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: widget.student.name);
    _classeController = new TextEditingController(text: widget.student.classe);
    _ageController = new TextEditingController(text: widget.student.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aluno'), backgroundColor: Colors.red),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome do Aluno'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _classeController,
              decoration: InputDecoration(labelText: 'Classe do aluno'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Idade do aluno'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.student.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.student.id != null) {
                  db.updateStudent(Student.fromMap({
                    'id': widget.student.id,
                    'name': _nameController.text,
                    'classe': _classeController.text,
                    'age': _ageController.text
                  })).then((_) { Navigator.pop(context, 'update'); });
                } else {
                  db.saveStudent(Student(_nameController.text, _classeController.text, _ageController.text)).then((_) { Navigator.pop(context, 'save'); });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
