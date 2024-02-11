import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
    CREATE TABLE nilaimhs(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama TEXT,
      nim TEXT,
      prodi TEXT,
      nilaiUas TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('nilaimhs.db', version: 1,
    onCreate: (sql.Database database, int version) async{
      await createTable(database);
    });
  }

  //input
  static Future<int> inputNilai(String nama, String nim, String prodi, String nilaiUas) async {
    final db = await SQLHelper.db();
    final data = {'nama': nama, 'nim': nim, 'prodi': prodi, 'nilaiUas': nilaiUas};
    return await db.insert('nilaimhs', data);
  }

  static Future<List<Map<String, dynamic>>> getNilaiMhs() async{
    final db = await SQLHelper.db();
    return db.query('nilaimhs');
  }

    //update
  static Future<int> updateNilai(int id, String nama, String nim, String prodi, String nilaiUas) async {
    final db = await SQLHelper.db();
    final data = {'nama': nama, 'nim': nim, 'prodi': prodi, 'nilaiUas': nilaiUas};
    return await db.update('nilaimhs', data, where: "id = $id");
  }

    //delete
  static Future<void> deleteNilai(int id) async {
    final db = await SQLHelper.db();
    await db.delete('nilaimhs', where: "id = $id");
  }
}

class SQLHelperSec {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
    CREATE TABLE nilaiutsmhs(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama TEXT,
      nim TEXT,
      prodi TEXT,
      nilaiUts TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('nilaiutsmhs.db', version: 1,
    onCreate: (sql.Database database, int version) async{
      await createTable(database);
    });
  }

  //input
  static Future<int> inputNilai(String nama, String nim, String prodi, String nilaiUas) async {
    final db = await SQLHelperSec.db();
    final data = {'nama': nama, 'nim': nim, 'prodi': prodi, 'nilaiUts': nilaiUas};
    return await db.insert('nilaiutsmhs', data);
  }

  static Future<List<Map<String, dynamic>>> getNilaiUtsMhs() async{
    final db = await SQLHelperSec.db();
    return db.query('nilaiutsmhs');
  }

    //update
  static Future<int> updateNilai(int id, String nama, String nim, String prodi, String nilaiUas) async {
    final db = await SQLHelperSec.db();
    final data = {'nama': nama, 'nim': nim, 'prodi': prodi, 'nilaiUts': nilaiUas};
    return await db.update('nilaiutsmhs', data, where: "id = $id");
  }

    //delete
  static Future<void> deleteNilai(int id) async {
    final db = await SQLHelperSec.db();
    await db.delete('nilaiutsmhs', where: "id = $id");
  }
}