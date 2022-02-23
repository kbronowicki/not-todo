import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:not_todo/models/models.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'not_todo_database.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE notTodos(id STRING PRIMARY KEY, task STRING NOT NULL, completed INTEGER NOT NULL, date STRING NOT NULL)');
      },
    );
    return _db!;
  }

  Future<List<NotTodo>> getDayNotTodos(String day) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'notTodos',
      where: 'date = ?',
      whereArgs: [day],
    );
    List<NotTodo> notTodos = maps.map((map) => NotTodo.fromMap(map)).toList();
    return notTodos;
  }

  Future<void> insertNotTodo(NotTodo notTodo) async {
    final db = await database;
    await db.insert(
      'notTodos',
      notTodo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNotTodo(NotTodo notTodo) async {
    final db = await database;
    await db.update(
      'notTodos',
      notTodo.toMap(),
      where: 'id = ?',
      whereArgs: [notTodo.id],
    );
  }

  Future<void> deleteNotTodo(NotTodo notTodo) async {
    final db = await database;
    await db.delete(
      'notTodos',
      where: 'id = ?',
      whereArgs: [notTodo.id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('notTodos');
  }
}
