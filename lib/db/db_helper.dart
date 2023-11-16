import 'package:sqflite/sqflite.dart';
import 'package:travel_app/jasonModel/model.dart';
import 'package:travel_app/jasonModel/user.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final databaseName = "packages.db";
  String packageTable =
      "CREATE TABLE packageTable (packageId INTEGER PRIMARY KEY AUTOINCREMENT, chiplabels TEXT NOT NULL, imageurl, imagepackagedetails TEXT, packagedetails TEXT ,packageprize text)";


  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usremail TEXT, usrPassword TEXT, usrConfirmPassword TEXT)";


  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(packageTable);
    });
  }


  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }

  //Search Method
  Future<List<PackageModel>> searchPackage(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from packageTable where imagepackagedetails LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => PackageModel.fromMap(e)).toList();
  }

  //CRUD Methods

  //Create packages
  Future<int> createPackage(PackageModel packageTable) async {
    final Database db = await initDB();
    return db.insert('packageTable', packageTable.toMap());
  }

  //read packages
  Future<List<PackageModel>> readPackageTable() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('packageTable');
    return result.map((e) => PackageModel.fromMap(e)).toList();
  }

  //Delete packages
  Future<int> deletePackage(int id) async {
    final Database db = await initDB();
    return db.delete('packageTable', where: 'packageId = ?', whereArgs: [id]);
  }

  //Update packages
  Future<int> updatePackages(imageUrl, imagepackagedetails, packagedetails, packageprize) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update packageTable set imageUrl = ?, imagepackagedetails = ?,  packagedetails = ?, packageprize = ? where packageId = ?',
        [imageUrl, imagepackagedetails, packagedetails, packageprize]);
  }
}