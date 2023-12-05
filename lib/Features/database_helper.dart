import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'dolisto_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        details TEXT,
        dueDate TEXT,
        isDone INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE deleted_tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        details TEXT,
        dueDate TEXT,
        isDone INTEGER
      )
    ''');
  }

  Future<int> insertTask(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryTasks(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<void> deleteTask(int taskId) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }
}