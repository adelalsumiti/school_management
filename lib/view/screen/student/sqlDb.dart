// import 'dart:developer';
// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// // import 'package:get/get.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';

// // import 'package:sqflite/sqflite.dart';

// class SqlDb {
//   static Database? _db;
//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDb();
//       return _db;
//     }
//     return _db;
//   }
// //

//   Future<String> getDatabasePath() async {
//     // طلب إذن الوصول إلى وحدة التخزين
//     var status = await Permission.storage.request();
//     if (!status.isGranted) {
//       throw Exception("Permission denied");
//     }
//     // إذا كان النظام Android 11 أو أعلى، احصل على مسار "Downloads"
//     if (Platform.isAndroid && (await getAndroidVersion()) >= 30) {
//       Directory downloadsDir = Directory('/storage/emulated/0/Download');

//       // تأكد من وجود مجلد FatortyDB داخل مجلد Downloads
//       String dbFolderPath = join(downloadsDir.path, 'School_Management');
//       if (!await Directory(dbFolderPath).exists()) {
//         await Directory(dbFolderPath).create(recursive: true);
//       }
//       // المسار النهائي للملف
//       String dbPath = join(dbFolderPath, 'audioFile.acc');
//       log(dbPath, error: dbPath);
//       return dbPath;
//     }

//     // إذا كان الإصدار أقل من Android 11
//     Directory? externalDir = await getExternalStorageDirectory();
//     if (externalDir == null) {
//       throw Exception("Unable to access external storage");
//     }

//     String dbFolderPath = join(externalDir.path, 'School_Management');
//     if (!await Directory(dbFolderPath).exists()) {
//       await Directory(dbFolderPath).create(recursive: true);
//     }

//     String dbPath = join(dbFolderPath, 'audioFile.acc');

//     return dbPath;
//   }

// // دالة الحصول على إصدار Android
//   Future<int> getAndroidVersion() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     return androidInfo.version.sdkInt; // هذا يعيد رقم SDK الخاص بإصدار Android
//   }

// // فتح أو إنشاء قاعدة البيانات
//   Future<Database> intialDb() async {
//     // الحصول على المسار النهائي للقاعدة
//     String dbPath = await getDatabasePath();
//     // فتح أو إنشاء قاعدة البيانات
//     Database mydb = await openDatabase(
//       dbPath,
//       version: 3,
//       onCreate: _onCreate,
//     );
//     print("Database Path: $dbPath");
//     return mydb;
//   }

//   _onUpgrade(Database db, int oldversion, int newversion) async {
//     print(" onUpgrade ===================================");
//   }

//   _onCreate(Database db, int version) async {
//     Batch batch = db.batch();

//     await db.execute('''
  
//           CREATE TABLE school_management (
//           "student_id" INTEGER NULL,
//           "teacher_id" INTEGER NULL,
//           "audio_note_path" TEXT NULL
//         )

// ''');
//     print(" onCreate ===================================");

//     await batch.commit();
//   }

//   //
//   //
//   insert(String table, Map<String, Object?> values) async {
//     Database? mydb = await db;
//     int response = await mydb!.insert(table, values);

//     return response;
//   }

//   Future<List<Map<String, Object?>>?> query(String table,
//       {String? where, List<dynamic>? whereArgs}) async {
//     // print("111object============================================");

//     var dbClient = await db;
//     // print("111object==$dbClient==========================================");

//     return await dbClient?.query(table, where: where, whereArgs: whereArgs);
//   }

//   read(String table) async {
//     Database? mydb = await db;
//     List<Map> response = await mydb!.query(table);
//     return response;
//   }

//   delet(String table, String? where) async {
//     Database? mydb = await db;
//     int response = await mydb!.delete(table, where: where);
//     return response;
//   }

//   mydeleteDatabase() async {
//     String databasepath = await getDatabasesPath();

//     String path = join(databasepath, 'audioFile.acc');

//     await deleteDatabase(path);
//   }
// }
