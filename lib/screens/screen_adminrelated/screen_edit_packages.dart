import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/package.dart';
import 'package:travel_app/screens/screen_adminrelated/screen_admin.dart';
import 'package:travel_app/utils/lists.dart';

class ScreenEditPackages extends StatefulWidget {
  const ScreenEditPackages({super.key,required this.editPackage});
  final Package editPackage;

  @override
  State<ScreenEditPackages> createState() => _ScreenEditPackagesState();
}

class _ScreenEditPackagesState extends State<ScreenEditPackages> {
  final _formKey = GlobalKey<FormState>();
  final _packageNameController = TextEditingController();
  final _packageDescriptionController = TextEditingController();
  final _packagePrizeController = TextEditingController();
  String category = '';
  XFile? _image;

  @override
  void initState() {
  super.initState();
  _packageNameController.text = widget.editPackage.name;
  _packageDescriptionController.text = widget.editPackage.description;
  _packagePrizeController.text = widget.editPackage.prize;
  category = widget.editPackage.category;
  _image=XFile(widget.editPackage.imageUrl);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Center(child: Text("Edit Packages")),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 15),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body:  Container(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * .27,
                  width: MediaQuery.of(context).size.width * 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _image == null
                    ? const Center(
                    child: Text(
                    'No image selected',
                    style: TextStyle(color: Colors.blue),
                    ),
                  )
                 : Image.file(
                File(_image!.path),
               fit: BoxFit.cover,
               ),

                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          color: Colors.blue,
                        ),
                        Text(
                          "Ad images",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  "Package Details",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20,),
                DropdownButtonFormField(
                  value: category,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Choose a Section";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.blue[200],
                    ),
                    dropdownColor: Colors.white,
                    hint: const Text(
                      "Categories",
                      style: TextStyle(color: Colors.blue),
                    ),
                    items: chipLabels.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value.toString();
                      });
                    }),
                const SizedBox(height: 20,),
                addPackageFormField(
                  labeltext: const Text("Package Name"),
                  textController: _packageNameController,
                  addPackagevalidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Package Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                addPackageFormField(
                  labeltext: const Text("Package Description"),
                  textController: _packageDescriptionController,
                  addPackagevalidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Package Description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                addPackageFormField(
                  fieldInputType: const TextInputType.numberWithOptions(),
                  labeltext: const Text("Package Prize"),
                  textController: _packagePrizeController,
                  addPackagevalidator: (value) {
                    if (value == null || value.isEmpty) {
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
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      child: const Text(
                        "Save New changes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "You must select an image",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final package = Package(
                              packageId: widget.editPackage.packageId,
                              category: category,
                              imageUrl: _image!.path,
                              name: _packageNameController.text,
                              description:
                                  _packageDescriptionController.text,
                              prize: _packagePrizeController.text,
                            );

                            final value =
                                await DatabaseHelper().updatePackages(package);
                            if (value > 0) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Successfully Edited  package"),
                                ),
                              );
                               // ignore: use_build_context_synchronously
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ScreenAdmin()));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Please fix the errors in the form",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget addPackageFormField({
    required Text labeltext,
    required TextEditingController textController,
    required String? Function(String?) addPackagevalidator,
    TextInputType? fieldInputType,
  }) {
    return TextFormField(
        keyboardType: fieldInputType,
        controller: textController,
        style: const TextStyle(color: Colors.blue),
        decoration: InputDecoration(
          label: labeltext,
          labelStyle: const TextStyle(color: Colors.blue),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.blue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.blue)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: addPackagevalidator);
  }

  Future<void> _getImage() async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final file = File(image.path);
    if (await file.exists()) {
      setState(() {
        _image = image;
      });
    } 
  }
} 
}
