import 'package:flutter/material.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/user.dart';

class ScreenSignedUsers extends StatefulWidget {
  const ScreenSignedUsers({super.key});

  @override
  State<ScreenSignedUsers> createState() => _ScreenSignedUsersState();
}

class _ScreenSignedUsersState extends State<ScreenSignedUsers> {
   List<Users> _user = [];

   fetchAllUsers()async{
    List<Users>user=await DatabaseHelper().getAllUsers();
    setState(() {
      _user=user;
    });
   }

   delete(int id)async{
    await DatabaseHelper().deleteUser(id);
   }

   @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Center(child: Text("Users List")),
        titleTextStyle: const TextStyle(color: Colors.black,),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
          Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        itemCount: _user.length,
        itemBuilder: (context, index) {
          Users user=_user[index];
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Card(
              borderOnForeground: true,
              elevation: 15,
              shadowColor: Colors.blue,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.person)),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("USER NAME:  ${user.usrName}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                    Text("PASSWORD :  ${user.usrPassword}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                  ],
                ),
                trailing: IconButton(onPressed: (){
                   showDialog(
                         context: context,
                         builder: (BuildContext context) {
                         return AlertDialog(
                          backgroundColor: Colors.black45,  
                         title: const Text("Delete Plan",),
                         titleTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
                         content: const Text("Are you sure you want to delete this User?"),
                         contentTextStyle: const TextStyle(color: Colors.white),
                         actions: [
                         TextButton(
                         onPressed: () {
                         Navigator.of(context).pop();
                         },
                         child: const Text("Cancel"),
                          ),
                        TextButton(
                         onPressed: () {
                          delete(user.usrId !);
                          Navigator.of(context).pop();
                         },
                        child: const Text("Delete",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
                }, icon: const Icon(Icons.delete),color: Colors.red,),
              ),)
          );
        },
      ),
    );
  }
}