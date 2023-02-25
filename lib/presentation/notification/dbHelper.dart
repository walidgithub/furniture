import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/services/service_locator.dart';

class DbHelper {
  Database? _db;

  Future<Database?> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    String path = join(await getDatabasesPath(), 'furniture.db');
    _db = await openDatabase(path, version: 2, onCreate: (Database db, int v) {
      db.execute(
          'create table notifications(id integer primary key autoincrement, notificationText varchar(255), userName varchar(50))');
    },);
    return _db;
  }
}
