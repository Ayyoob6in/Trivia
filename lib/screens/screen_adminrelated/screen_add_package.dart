

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/utils/lists.dart';
class AddPackages extends StatefulWidget {
  const AddPackages({super.key});

  @override
  State<AddPackages> createState() => _AddPackagesState();
}

class _AddPackagesState extends State<AddPackages> {
  final _formKey = GlobalKey<FormState>();
  final _packageName = TextEditingController();
  final _packageDescription=TextEditingController();
  final _packagePrize=TextEditingController();
  XFile? _image;


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title:const Center(child: Text("Add Packages")),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 15),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, 
         icon:const Icon(Icons.arrow_back_ios),
        ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10,right: 20,left: 20 ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    height: MediaQuery.of(context).size.height*.27,
                    width: MediaQuery.of(context).size.width*10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _image == null
                  ? const Center(child: Text('No image selected',style: TextStyle(color: Colors.blue),))
                  : Image.file(File(_image!.path,),fit: BoxFit.cover,),
                  ),),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: _getImage,
                    child: Container(
                      height: MediaQuery.of(context).size.height*.06,
                      decoration:  BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.add_photo_alternate,color: Colors.blue,),
                        Text("Ad images",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.blue),)
                      ]),
                    ),
                  ),
                 const SizedBox(height: 20,),
                const Text("Package Details",style: TextStyle(fontSize: 17,color: Colors.blue,fontWeight: FontWeight.w500),),
                const SizedBox(height: 20,),
                DropdownButtonFormField(
                 validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Choose a Section";
                      }
                      return null;
                    },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(color: Colors.blue)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(color: Colors.blue)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down_circle,color: Colors.blue[200],), 
                  dropdownColor: Colors.white,
                  hint:const Text("Categories",style: TextStyle(color: Colors.blue),),
                  items: chipLabels.map((e){
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e,style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.w400),),
                    ); 
                }).toList(),
                 onChanged:(value){
                 }),
                const SizedBox(height: 20,),
                 addPackageFormField(
                  labeltext:const Text("Package Name"),
                   textController: _packageName,
                   addPackagevalidator: (value) {
                     if(value==null||value.isEmpty){
                       return "Enter Package Name";
                     }
                     return null;
                   },
                   ),
                const SizedBox(height: 20,),
                 addPackageFormField(
                  labeltext:const Text("Package Description"),
                   textController: _packageDescription,
                   addPackagevalidator: (value) {
                     if(value==null||value.isEmpty){
                       return "Enter Package Description";
                     }
                     return null;
                   },
                   ),
                 const SizedBox(height: 20,),
                   addPackageFormField(
                    fieldInputType: TextInputType.numberWithOptions(),
                  labeltext:const Text("Package Prize"),
                   textController: _packagePrize,
                   addPackagevalidator: (value) {
                     if(value==null||value.isEmpty){
                       return "Enter Package Prize";
                     }
                     return null;
                   },
                   ),
                  const SizedBox(height: 20,),
                   Center(
                     child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextButton(
                        child: Text("Add To Packages",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        onPressed: (){
                        if(_formKey.currentState!.validate()&&_image!=null){
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                         content: Text('Please select an image'),
                        duration: Duration(seconds: 2),
                        ),
                        );
                        }
                        },
                      ),
                     ),
                   )

                
                ],
              ),
            ),
          ),
        ),
    );
  }
  Widget addPackageFormField({required Text labeltext,required TextEditingController textController,required String? Function(String?) addPackagevalidator,TextInputType? fieldInputType}){
    return   TextFormField(
                 keyboardType:fieldInputType,
                 controller:textController,
                  style:const TextStyle(color: Colors.blue ),
                  decoration: InputDecoration(
                    label: labeltext,
                    labelStyle:const TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(color: Colors.blue,)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(color: Colors.blue)
                    ),
                    errorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),),
                    focusedErrorBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),),
                  ),
                  validator: addPackagevalidator
                 );
  }
    Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}