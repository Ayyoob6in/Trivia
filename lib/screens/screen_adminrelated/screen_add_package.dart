import 'package:flutter/material.dart';
class AddPackages extends StatefulWidget {
  const AddPackages({super.key});

  @override
  State<AddPackages> createState() => _AddPackagesState();
}

class _AddPackagesState extends State<AddPackages> {
  final List<String> chipLabels = [
    "Hill station",
    "Mountains",
    "WaterFalls",
    "Beaches",
    "Deserts",
    "Monuments",
  ];
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.25,
                  width: MediaQuery.of(context).size.width*10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network("https://i.ytimg.com/vi/NCPDTBufwvk/maxresdefault.jpg",fit: BoxFit.cover,)),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height*.05 ,
                    decoration:  BoxDecoration(
                       color: Colors.blue[100 ],
                     // border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.add_photo_alternate,color: Colors.black,),
                      Text("Add Image",style: TextStyle(fontWeight: FontWeight.w800,),)
                    ]),
                  ),
                ),
               const SizedBox(height: 10,),
              const Text("Package Details",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),

              DropdownButtonFormField(
                
                hint: Text("choose package"),
                items: chipLabels.map((e){
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                  ); 
              }).toList(),
               onChanged:(value){

               })
              
              ],
            ),
          ),
        ),
    );
  }
}