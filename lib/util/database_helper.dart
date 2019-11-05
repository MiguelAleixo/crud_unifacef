import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crud_unifacef/model/student.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableStudent = 'StudentTable';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';

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
    String path = join(databasesPath, 'Student.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableStudent($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT)');
  }

  Future<int> saveStudent(Student Student) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableStudent, Student.toMap());
    return result;
  }

  Future<List> getAllStudent() async {
    var dbClient = await db;
    var result = await dbClient.query(tableStudent,
        columns: [columnId, columnTitle, columnDescription]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableStudent'));
  }

  Future<Student> getStudent(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableStudent,
        columns: [columnId, columnTitle, columnDescription],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new Student.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteStudent(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableStudent, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateStudent(Student Student) async {
    var dbClient = await db;
    return await dbClient.update(tableStudent, Student.toMap(),
        where: "$columnId = ?", whereArgs: [Student.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
