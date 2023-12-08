import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/experinces.dart';
import 'package:travel_app/jasonModel/package.dart';
import 'package:travel_app/screens/screen_userrelated/screen_add_experince.dart';

class ScreenExperience extends StatefulWidget {
  final Package package;

  const ScreenExperience({super.key, required this.package});

  @override
  State<ScreenExperience> createState() => _ScreenExperienceState();
}

class _ScreenExperienceState extends State<ScreenExperience> {
  List<Experience> _experiences=[];
  delete(int id)async{
    await DatabaseHelper().deleteExperience(id);
    fetchExperiencesForPackage(widget.package.packageId !);
  }
  fetchExperiencesForPackage(int packageId) async {
  List<Experience> experiences = await DatabaseHelper().getExperiencesForPackage(packageId);
  setState(() {
    _experiences = experiences;
  });
}

  

  @override
  void initState() {
    super.initState();
    fetchExperiencesForPackage(widget.package.packageId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: Text(widget.package.name),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*.3,
                  width:  MediaQuery.of(context).size.width*2, 
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(widget.package.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Experiences",style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700
                ),),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: _experiences.length,
                    itemBuilder: (context, index) {
                      Experience experience=_experiences[index];
                      return Column(
                        children: [
                          const SizedBox(height: 10,),
                          ListTile(
                            title: Text(experience.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const SizedBox(height: 5,),
                                Text("Experience: ${experience.experiences}"),
                                Text("Expences: ${experience.totalExpences}"),
                                // Text(experience.totalExpences),
                              ],
                            ),
                            //subtitle: Text(experience.totalExpences),
                            trailing: IconButton(onPressed: (){
                              
                              showDialog(
                         context: context,
                         builder: (BuildContext context) {
                         return AlertDialog(
                          backgroundColor: Colors.black45,  
                         title: const Text("Delete Plan",),
                         titleTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
                         content: const Text("Are you sure you want to delete this plan?"),
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
                          delete(experience.id !);
                          Navigator.of(context).pop();
                         },
                        child: const Text("Delete",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
                            }, icon: Icon(Icons.delete,color: Colors.blue[300])),
                            leading: ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(10),
                              child: InstaImageViewer(
                                child: Image.file(
                                   File(experience.image)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,)
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 28 ,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScreenAddExperience(pid:widget.package.packageId,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blue,
                            blurStyle: BlurStyle.solid,
                            blurRadius: 5,
                            spreadRadius: 0.1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * .9 ,
                      child: Row(
                        children: [
                          const SizedBox(width: 20,),
                           Text(" Add Your Experience",style: TextStyle(
                            color: Colors.blue [200],
                            fontSize: 15,
                            fontWeight: FontWeight.w900
                          ),),
                           SizedBox(width: MediaQuery.of(context).size.width * 0.3,),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(
                              Icons.telegram,
                              size: 40,
                              color: Colors.blue[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) 
              ],
            ),
          ),
        ],
      ),
    );
  }
}