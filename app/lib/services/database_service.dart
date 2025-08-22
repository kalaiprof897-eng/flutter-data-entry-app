import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/data_entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static DatabaseService get instance => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'data_entries.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT,
        company TEXT,
        position TEXT,
        category TEXT,
        priority TEXT DEFAULT 'medium',
        notes TEXT,
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertDataEntry(DataEntry entry) async {
    final db = await database;
    return await db.insert('data_entries', entry.toMap());
  }

  Future<List<DataEntry>> getAllDataEntries() async {
    final db = await database;
    final maps = await db.query(
      'data_entries',
      orderBy: 'updatedAt DESC',
    );
    return maps.map((map) => DataEntry.fromMap(map)).toList();
  }

  Future<DataEntry?> getDataEntry(int id) async {
    final db = await database;
    final maps = await db.query(
      'data_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return DataEntry.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateDataEntry(DataEntry entry) async {
    final db = await database;
    return await db.update(
      'data_entries',
      entry.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteDataEntry(int id) async {
    final db = await database;
    return await db.delete(
      'data_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<DataEntry>> searchDataEntries(String query) async {
    final db = await database;
    final maps = await db.query(
      'data_entries',
      where: '''
        firstName LIKE ? OR 
        lastName LIKE ? OR 
        email LIKE ? OR 
        company LIKE ? OR 
        position LIKE ?
      ''',
      whereArgs: List.filled(5, '%$query%'),
      orderBy: 'updatedAt DESC',
    );
    return maps.map((map) => DataEntry.fromMap(map)).toList();
  }

  Future<List<DataEntry>> getDataEntriesByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'data_entries',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'updatedAt DESC',
    );
    return maps.map((map) => DataEntry.fromMap(map)).toList();
  }

  Future<int> getDataEntriesCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM data_entries');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> deleteAllDataEntries() async {
    final db = await database;
    await db.delete('data_entries');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
