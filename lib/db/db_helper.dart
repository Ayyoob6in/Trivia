
import 'package:sqflite/sqflite.dart';
import 'package:travel_app/jasonModel/experinces.dart';
import 'package:travel_app/jasonModel/package.dart';
import 'package:travel_app/jasonModel/tour_plan.dart';
import 'package:travel_app/jasonModel/user.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final databaseName = "packages.db";

  String experiences = "CREATE TABLE experience (id INTEGER PRIMARY KEY AUTOINCREMENT, packageId INTEGER NOT NULL, name TEXT NOT NULL, experiences TEXT NOT NULL, totalExpences TEXT NOT NULL, image TEXT NOT NULL, FOREIGN KEY (packageId) REFERENCES packageTable(packageId))";

   String myTourPlan = 
     "CREATE TABLE tourPlan (planId INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL, age TEXT NOT NULL, placeName TEXT NOT NULL, gender TEXT NOT NULL,date TEXT NOT NULL)";
  
  String packages =
    "CREATE TABLE packageTable (packageId INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT NOT NULL, imageUrl TEXT NOT NULL, name TEXT NOT NULL, description TEXT NOT NULL, prize TEXT NOT NULL)";

  String users ="CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usremail TEXT, usrPassword TEXT, usrConfirmPassword TEXT)";

      


  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(packages);
      await db.execute(myTourPlan);
      await db.execute(experiences);
    });
  }


//===========================================================================>
                //User Login And SignUp
//===========================================================================>


  Future<bool> login(Users user) async {
    final Database db = await initDB();

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

   Future<List<Users>> getAllUsers() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('users');
    return result.map((e) => Users.fromMap(e)).toList();
  }

  Future<void>deleteUser(int id)async{
    final Database db = await initDB();
    await db.rawDelete('DELETE FROM users WHERE usrId = ?',[id]);
  }

//===========================================================================>
                //AdminSide package  adding CRUD
//===========================================================================>

  Future<int> insertPackge(Package package)async{
   final Database database=await initDB();
   int result = await database.insert('packageTable', package.toMap());
   return result;
   
  }
 
  Future<List<Package>> getAllPackages() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('packageTable');
    return result.map((e) => Package.fromMap(e)).toList();
  }
  

  Future<void> deletePackage(int id) async {
  final Database db = await initDB();
  await db.rawDelete('DELETE FROM packageTable WHERE packageId = ?', [id]);
}

Future<int> updatePackages(Package updatedPackage) async {
  final Database db = await initDB();
  return await db.update(
    'packageTable',
    updatedPackage.toMap(),
    where: 'packageId = ?',
    whereArgs: [updatedPackage.packageId],
  );
}




//===========================================================================>
                //Tour Plan
//===========================================================================>


Future<int> insertTourplan(TourPlan tourPlan)async{
  return initDB().then((Database database) async {
    int result = await database.insert("tourPlan", tourPlan.toMap());
    return result;
  });
}

Future<List<Experience>> getExperiencesForPackage(int packageId) async {
  final Database exDb = await initDB();
  List<Map<String, Object?>> result = await exDb.query(
    "experience",
    where: 'packageId = ?',
    whereArgs: [packageId],
  );
  return result.map((e) => Experience.fromMap(e)).toList();
}


Future<List<TourPlan>> getallPlans()async{
  final Database newdb = await initDB();
  List<Map<String,Object?>> result = await newdb.query("tourPlan");
  return result.map((e) => TourPlan.fromMap(e)).toList();
}

Future deletePlan(int id)async{
  final Database newdb = await initDB();
  await newdb.rawDelete("DELETE FROM tourPlan WHERE planId= ?",[id]);
}

Future<int> updatePlan(TourPlan updatedPlan) async {
  final Database db = await initDB();
  return await db.update(
    'tourPlan',
    updatedPlan.toMap(),
    where: 'planId = ?',
    whereArgs: [updatedPlan.planId],
  );
}

//===========================================================================>
                //Experience
//===========================================================================>


Future<int> insertExperiences(Experience experience)async{
  return initDB().then((Database database) async {
    int result = await database.insert("experience", experience.toMap());
    return result;
  });
}

Future<List<Experience>> getallExperience()async{
  final Database exDb = await initDB();
  List<Map<String,Object?>> result = await exDb.query("experience");
  return result.map((e) => Experience.fromMap(e)).toList();
}

Future<void> deleteExperience(int id) async {
  final Database db = await initDB();
  await db.delete('experience', where: 'id = ?', whereArgs: [id]);
}









  //Search Method
  // Future<List<Package>> searchPackage(String keyword) async {
  //   final Database db = await initDB();
  //   List<Map<String, Object?>> searchResult = await db
  //       .rawQuery("select * from packageTable where imagepackagedetails LIKE ?", ["%$keyword%"]);
  //   return searchResult.map((e) => Package.fromMap(e)).toList();
  // }


}  