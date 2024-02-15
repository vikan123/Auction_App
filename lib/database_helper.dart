import 'package:auction_app/modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'auction.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Product (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        price REAL
      )
    ''');
  }
  Future<int> insertProduct(Product product) async {
    Database dbClient = await db;
    return await dbClient.insert('Product', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('Product');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<int> updateProduct(Product product) async {
    Database dbClient = await db;
    return await dbClient.update('Product', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int> deleteProduct(int id) async {
    Database dbClient = await db;
    return await dbClient.delete('Product', where: 'id = ?', whereArgs: [id]);
  }

}

