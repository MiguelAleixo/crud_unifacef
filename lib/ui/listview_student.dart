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
 
    db.getAllStudents().then(students) {
      setState(() {
        Students.forEach((student) {
          items.add(student.fromMap(student));
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
          title: Text('ListView Demo'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].name}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].classe}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${items[position].id}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
  icon: const Icon(Icons.remove_circle_outline),
  onPressed: () => _deleteStudent(context, items[position], position)),
                        ],
                      ),
              onTap: () => _navigateToStudent(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewStudent(context),
        ),
      ),
    );
  }
 
  void _deleteStudent(BuildContext context, Student student, int position) async {
    db.deleteStudent(student.id).then((students) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
 
  void _navigateToStudent(BuildContext context, Student student) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentScreen(student)),
    );
 
    if (result == 'update') {
      db.getAllStudents().then((students) {
        setState(() {
          items.clear();
          students.forEach((student) {
            items.add(Student.fromMap(student));
          });
        });
      });
    }
  }
 
  void _createNewStudent(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentScreen(Student('', ''))),
    );
     //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getAllStudents().then((students) {
        setState(() {
          items.clear();
          students.forEach((student) {
            items.add(Student.fromMap(student));
          });
        });
      });
    }
  }
}
