import 'package:schedule_reminder/model/reminderformat.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper1{
  static Database? _db;
  static final int _version=1;
  static final String _tableName= "reminders";
  static Future<void> initDb() async{
    if((_db!=null))
    {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'rem.db';
      _db= await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          print("creating a new one");
          return db.execute(
            "Create TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, dosage STRING, "
            "startTime STRING, repeat STRING )",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  static Future<int> insert(Reminder? rem) async{
   print("insert function called");
   return await _db!.insert(_tableName, rem!.toJson());
  }
  static Future<List<Map<String, dynamic>>> query() async{
   print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Reminder rem) async {
   await _db!.delete(_tableName, where: 'id=?', whereArgs: [rem.id]);
  }

}