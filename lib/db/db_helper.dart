import 'package:schedule_reminder/model/appoint.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "Appointments";

  static Future<void> initDb()async{
    if(_db !=null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'appointment.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          print("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "name STRING, docName STRING, phoneNo STRING, address STRING, date STRING,"
                "startTime STRING, endTime STRING,"
                "remind INTEGER) ",

          );
        },
      );
    } catch (e){
      print(e);
    }
  }

  static Future<int> insert(Appointment? appoin) async{
    print("insert function called");
    return await _db?.insert(_tableName, appoin!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Appointment appointment)async{
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [appointment.id]);
  }
}