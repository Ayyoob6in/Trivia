import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/tour_plan.dart';
import 'package:travel_app/screens/screen_userrelated/screen_planned_packages.dart';

class ScreenEditPlans extends StatefulWidget {
  const ScreenEditPlans({super.key,required this.editTourPlan});
  final TourPlan editTourPlan;

  @override
  State<ScreenEditPlans> createState() => _ScreenEditPlansState();
}

class _ScreenEditPlansState extends State<ScreenEditPlans> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final placeNameController = TextEditingController();
  final dateController=TextEditingController();
  List<String> genders = ["Male", "Female", "Non-Binary", "Other"];

  @override
  void initState() {
    super.initState();
    nameController.text=widget.editTourPlan.name;
    ageController.text=widget.editTourPlan.age;
    genderController.text=widget.editTourPlan.gender;
    placeNameController.text=widget.editTourPlan.placeName;
    dateController.text=widget.editTourPlan.date;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Center(child: Text("Edit Your Trip Plan")),
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
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin:const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 30, right: 30,),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.height * 0.5, 
                  child: Column(
                    children: [
                     const SizedBox(height: 40), 
                      const Text(
                        "Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                     const SizedBox(height:40,),
                      Row(
                        children: <Widget>[
                          bookingField(
                            label: const Text("Name"),
                            validator: (value) {
                              if (value == null||value.isEmpty) {
                                return "Enter Name";
                              }
                              return null;
                            },
                            controller: nameController,
                          ),
                          const SizedBox(width: 40),
                          bookingField(
                            label: const Text("Age"),
                            validator: (value) {
                              if (value == null||value.isEmpty) {
                                return "Enter Age";
                              }
                              return null;
                            },
                            controller: ageController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: <Widget>[
                          bookingField(
                            label: const Text("Place Name"),
                            validator: (value) {
                              if (value == null||value.isEmpty) {
                                return "Enter Place Name";
                              }
                              return null;
                            },
                            controller: placeNameController,
                          ),
                          const SizedBox(width: 40),
                          Flexible(
                            child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Choose Gender";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.black),
                                dropdownColor: Colors.white,
                                hint: const Text("Genders", style: TextStyle(color: Colors.black)),
                                items: genders.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    genderController.text = value.toString();
                                  });
                                }),
                          ),
                        ],
                      ),
                     const SizedBox(height: 40,),
                      Row(
                        children: [ 
                         bookingField(
                          readonly: true,
                          trailingIcon: IconButton(
                            onPressed: ()async{
                             DateTime? pickedDate = await showDatePicker(
                              context: context,
                               initialDate: DateTime.now(),
                               firstDate:DateTime(2000), 
                               lastDate: DateTime(2101),
                               );
                               if(pickedDate!=null){
                               String formattDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                               setState(() {
                                 dateController.text=formattDate;
                               });
                               }else{
                                return;
                               }
                            },
                             icon:const Icon(
                              Icons.calendar_today,
                              color: Colors.black
                              )
                              ), 
                          hint:  "YYYY-MM-DD",
                          validator: (value){
                          if(value==null||value.isEmpty){
                            return "Choose Date";
                          }return null;
                          }, 
                          controller: dateController
                          )
                       
                       ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.07), 
                    GestureDetector(
                      child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.blue),
                       borderRadius: BorderRadius.circular(20),
                       ),
    child: const Center(
      child: Text("Schedule", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
    ),
  ),   onTap: () async {
  if (_formKey.currentState!.validate()) {
    final tourPlan = TourPlan(
      planId:widget.editTourPlan.planId ,
      name: nameController.text,
      age: ageController.text,
      placeName: placeNameController.text,
      gender: genderController.text,
      date: dateController.text,
    );

    final value = await DatabaseHelper().updatePlan(tourPlan);
    print('Update result: $value');
    
    if (value > 0) {
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Successfully edited your plan"),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreePlannedPackages()));
    } 
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Please fill in all required fields"),
      ),
    );
  }
},


),

                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("T",style: GoogleFonts.amiri(
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 70,
                    )
                    )),
                    Text("rivia",style: GoogleFonts.aleo(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                    )
                    )),
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
  Widget bookingField({

    Text? label,
    required String? Function(String?)? validator,
    required TextEditingController controller,
    bool readonly=false,
    Widget? trailingIcon,
    String? hint,
    
  }) {
    return Flexible(
      child: TextFormField(
        readOnly:readonly,
        controller: controller,
        validator: validator,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black),
          suffixIcon:trailingIcon,
          label: label,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}