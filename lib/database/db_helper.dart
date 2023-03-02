import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_manager/database/category.dart';
import 'package:stock_manager/database/history.dart';
import 'package:stock_manager/database/product.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._privateConstructor();
  DBHelper._privateConstructor();

  factory DBHelper() {
    return _instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY,
          name TEXT,
          pieces_per_box INTEGER,
          individual_pieces INTEGER,
          category_id INTEGER,
          date_added TEXT,
          FOREIGN KEY (category_id) REFERENCES categories(id)
        )
      ''');

    await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY,
          name TEXT,
          color TEXT
        )
      ''');

    await db.execute('''
        CREATE TABLE history(
          id INTEGER PRIMARY KEY,
          product_id INTEGER,
          datetime TEXT,
          quantity_box INTEGER,
          quantity_piece INTEGER,
          
          FOREIGN KEY (product_id) REFERENCES products(id)
        )
      ''');
  }

//Products

  Future<int> insertProduct(Product product) async {
    final Database db = await _instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final Database db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(
      maps.length,
      (index) {
        return Product.fromMap(maps[index]);
      },
    );
  }

  Future<List<Product>> searchProducts(String searchText) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM products WHERE name LIKE '%$searchText%'");
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<int> updateProduct(Product product) async {
    final Database db = await _instance.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
  Future<Product?> getProductById(int id) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'products',
    where: 'id = ?',
    whereArgs: [id],
    limit: 1,
  );

  if (maps.isNotEmpty) {
    return Product.fromMap(maps.first);
  }
  return null;
}


  Future<int> deleteProduct(int id) async {
    final Database db = await _instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>> getProductsByCategoryId(int categoryId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM products WHERE category_id = ?', [categoryId]);

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

// Category

  Future<int> insertCategory(Category category) async {
    final Database db = await _instance.database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    final Database db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(
      maps.length,
      (index) {
        return Category.fromMap(maps[index]);
      },
    );
  }

  Future<int> updateCategory(Category category) async {
    final Database db = await _instance.database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final Database db = await _instance.database;
    await deleteProductsByCategoryId(id);
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteProductsByCategoryId(int categoryId) async {
    final db = await _instance.database;

    await db.delete(
      'products',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
  }

  Future<Category> getCategoryById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('categories', where: "id = ?", whereArgs: [id]);

    return Category.fromMap(result.first);
  }

// History

  // create
  Future<int> createHistory(History history) async {
    final db = await database;
    return await db.insert('history', history.toMap());
  }

  // read
  Future<List<History>> getAllHistories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history');
    return List.generate(maps.length, (i) {
      return History.fromMap(maps[i]);
    });
  }

  Future<List<History>> getHistoriesByProductId(int productId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'history',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    return List.generate(maps.length, (i) {
      return History.fromMap(maps[i]);
    });
  }

  // update
  Future<int> updateHistory(History history) async {
    final db = await database;
    return await db.update(
      'history',
      history.toMap(),
      where: 'id = ?',
      whereArgs: [history.id],
    );
  }

  // delete
  Future<int> deleteHistory(int id) async {
    final db = await database;
    return await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteHistoriesByProductId(int productId) async {
    final db = await database;
    return await db.delete(
      'history',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }
}
