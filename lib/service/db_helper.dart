import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cartmodel.dart';

class DBHelper {
  static const String createTableCarts = '''create table $tablecart(
  $tablecartid integer primary key autoincrement,
  $tablecartproductselect integer,
  $tablecartproductname text,
  $tablecartproductprice integer,
  $tablecartproductsize text,
  $tablecartproductquantity integer,
  $tablecartproductimage text,
  $tablecartproducttotalprice integer
  )''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = join(rootPath, 'cart.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableCarts);
    });
  }

  static Future<int> insertcart(AddCartModel addCartModel) async {
    final db = await open();
    return db.insert(tablecart, addCartModel.toMap());
  }

  static Future<List<AddCartModel>> getAllCarts() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tablecart);
    return List.generate(
        mapList.length, (index) => AddCartModel.fromMap(mapList[index]));
  }

  static Future<int> updatequantity(int? id, int value) async {
    final db = await open();
    return db.update(tablecart, {tablecartproductquantity: value},
        where: '$tablecartid = ?', whereArgs: [id]);
  }

  static Future<int> updatetotalprice(int? id, String value) async {
    final db = await open();
    return db.update(tablecart, {tablecartproducttotalprice: value},
        where: '$tablecartid = ?', whereArgs: [id]);
  }

  static Future<int> updateselection(int? id, int value) async {
    final db = await open();
    return db.update(tablecart, {tablecartproductselect: value},
        where: '$tablecartid = ?', whereArgs: [id]);
  }
}
