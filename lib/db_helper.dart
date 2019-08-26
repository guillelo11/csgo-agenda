import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database _database;
  static final _databaseName = "CSGO_agenda.db";
  static final _databaseVersion = 1;

  DbHelper._privateConstructor();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = databasesPath + _databaseName;
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE favorite_match (
            id INTEGER PRIMARY KEY,
            match_id INTEGER,
            start_date TEXT NOT NULL
          )
          ''');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query('favorite_match');
  }

  Future<List<Map<String, dynamic>>> queryFavorites() async {
    Database db = await instance.database;
    return await db.query('favorite_match', columns: ['match_id']);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('favorite_match', row);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete('favorite_match', where: 'match_id = ?', whereArgs: [id]);
  }
}
