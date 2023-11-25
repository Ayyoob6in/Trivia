import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/experinces.dart';
import 'package:travel_app/screens/screen_userrelated/home_screen.dart';

class ScreenAddExperience extends StatefulWidget {
  const ScreenAddExperience({super.key,required this.pid});
  // ignore: prefer_typing_uninitialized_variables
  final  pid;

  @override
  State<ScreenAddExperience> createState() => _ScreenAddExperienceState();
}

class _ScreenAddExperienceState extends State<ScreenAddExperience> {
  final _formKey = GlobalKey<FormState>();
  final _nameController=TextEditingController();
  final _experienceController=TextEditingController();
  final _totalExpencesController=TextEditingController();
  XFile? _experinceImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Center(child: Text("Add Your Experiences")),
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
    body: Container(
      decoration: const BoxDecoration(
       color: Colors.white
      ),
      height: double.infinity,
      width: double.infinity,
child: SingleChildScrollView(
  child:Padding(
    padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
             validator: (value) {
              if(value==null || value.isEmpty){
                return "Enter your Name";
              }return null;
            },
           decoration:  InputDecoration(
            label: const Text("Name"),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(20),
               borderSide: const BorderSide(color: Colors.blue)
             ),focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)
             ),
             errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20)
             ),
             focusedErrorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red)
             ),
           ),
          ),
         const SizedBox(height: 20,), 
          TextFormField(
            controller: _experienceController,
            validator: (value) {
              if(value==null || value.isEmpty){
                return "Add your Experience";
              }return null;
            },
           decoration:  InputDecoration(
            label:const Text("Add Your Experience Here....",),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(20),
               borderSide: const BorderSide(color: Colors.blue)
             ),focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)
             ),
             errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20)
             ),
             focusedErrorBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20) 
             ),
           ),
          ),
         const SizedBox(height: 20,),
          TextFormField(
            controller: _totalExpencesController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if(value==null || value.isEmpty){
                return "Add your Total Expences";
              }return null;
            },
           decoration:  InputDecoration(
            label:const Text("Total Expences",),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(20),
               borderSide: const BorderSide(color: Colors.blue)
             ),focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)
             ),
             errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20)
             ),
             focusedErrorBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20) 
             ),
           ),
          ),
      const SizedBox(height: 20,),
      Container(
       height: MediaQuery.of(context).size.height*.3,
      width: MediaQuery.of(context).size.width*0.9,
       decoration: BoxDecoration(
       color: Colors.white,
       border: Border.all(color: Colors.blue),
       borderRadius: BorderRadius.circular(20),
           ),
           child:ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _experinceImage==null ? IconButton(
              onPressed: (){
                _getImage();
              },
               icon: const Icon(Icons.add_a_photo,color: Colors.blue,)):Image.file(File(_experinceImage!.path,),fit: BoxFit.cover,),
           )
          ),
         const SizedBox(height: 10,),
          GestureDetector(
            child: Container(
             height: MediaQuery.of(context).size.height*.05,
              width: MediaQuery.of(context).size.width*0.2,
               decoration: BoxDecoration(
               border: Border.all(color: Colors.blue),
               borderRadius: BorderRadius.circular(20),
             ),
             child:const Center(child: Text("Add ",style: TextStyle(color: Colors.blue),)),
            ),
            onTap: ()async{
              if(_formKey.currentState!.validate()){
               if(_experinceImage==null){
                ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     backgroundColor: Colors.red,
                      content: Text('Select an Image'),
                      duration: Duration(seconds: 2),
               ),
              );
               }else{
                final experience = Experience(
                  packageId: widget.pid,
                  name: _nameController.text,
                   experiences: _experienceController.text,
                    totalExpences: _totalExpencesController.text,
                     image: _experinceImage!.path
                     );
                     final value=await DatabaseHelper().insertExperiences(experience);
                     if(value>0){
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Added New Tour Plan"),
                      ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomeScreen()));
                     }

               }
                }else {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Fill Details'),
                duration: Duration(seconds: 2),
              ),
            );
          }
            },
          )
        ],
      ),
    ),
  ),
),
    )
    );
}
 Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final experinceimage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _experinceImage = experinceimage;
    });
  }
}