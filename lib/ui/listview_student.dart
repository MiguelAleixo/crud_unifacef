import 'package:flutter/material.dart';
import 'package:crud_unifacef/model/student.dart';
import 'package:crud_unifacef/util/database_helper.dart';
import 'package:crud_unifacef/ui/student.dart';
 
class ListViewStudent extends StatefulWidget {
  @override
  _ListViewStudentState createState() => new _ListViewStudentState();
}
 
class _ListViewStudentState extends State<ListViewStudent> {
  //atributo de vetor dos itens
  List<Student> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
 
  @override
  void initState() {
    super.initState();
 
    db.getAllStudent().then((student) {
      setState(() {
        student.forEach((student) {
          items.add(Student.fromMap(student));
        });
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSA ListView Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listagem dos alunos'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 0.0),
                  ListTile(
                    title: Text(
                      'Nome do aluno: ${items[position].name}\nIdade do aluno: ${items[position].age}',
                      style: TextStyle(fontSize: 14.0, color: Colors.black, fontStyle: FontStyle.italic)),
                      subtitle: Text('${items[position].classe}', style: new TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(0.0)),
                          Text('${items[position].id}', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                          SizedBox(
                            height: 18.0,
                            width: 18.0,
                            child: new IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteStudent(context, items[position], position)
                            )
                          ),
                        ],
                      ),
                      onTap: () => _navigateToStudent(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => _createNewStudent(context)),
      ),
    );
  }
 
  void _deleteStudent(BuildContext context, Student student, int position) async {
    db.deleteStudent(student.id).then((student) {
      setState(() { items.removeAt(position); });
    });
  }
 
  void _navigateToStudent(BuildContext context, Student student) async {
    String result = await Navigator.push(context, MaterialPageRoute(builder: (context) => StudentScreen(student)));
 
    if (result == 'update') {
      db.getAllStudent().then((student) {
        setState(() {
          items.clear();
          student.forEach((student) {
            items.add(Student.fromMap(student));
          });
        });
      });
    }
  }
 
  void _createNewStudent(BuildContext context) async {
    String result = await Navigator.push(context, MaterialPageRoute(builder: (context) => StudentScreen(Student('', '', ''))));
    if (result == 'save') {
      db.getAllStudent().then((student) {
        setState(() {
          items.clear();
          student.forEach((student) {
            items.add(Student.fromMap(student));
          });
        });
      });
    }
  }
}
