import 'package:flutter/material.dart';
import 'package:travel_app/screens/models/allmodels.dart';

class PackageDetails extends StatefulWidget {
  final ImageDetails details;
  final ImageDetails imagePackageDetails;
  final ImageDetails packageInformation;
  final ImageDetails packagePrize;
  final int currentIndex;

  const PackageDetails({
    super.key,
    required this.details,
    required this.currentIndex,
    required this.imagePackageDetails,
    required this.packageInformation,
    required this.packagePrize
    });

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black,size: 20),
        title:const Center(child: Text("Package Details")),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 15),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white24,
            height: MediaQuery.of(context).size.height*.78,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height*.30,
                    width:MediaQuery.of(context).size.height*.40,
                    child: ClipRRect(
                borderRadius: BorderRadius.circular(20 ),
                child: Image.network(widget.details.imageUrl,fit: BoxFit.cover,
                ),
                ),
                ),
              const SizedBox(height: 10,), 
                Text(widget.imagePackageDetails.imagepackageDetails,style: const TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),
                  ),
                 const SizedBox(height: 5,),
                 const Text("Description",style: TextStyle(fontSize: 22),),
                 const SizedBox(height: 7,),
                 Text(widget.imagePackageDetails.packageInformation,style:const TextStyle(wordSpacing: 2.5),),
                const SizedBox(height: 30,),
                 Center(
                   child: Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      border:  Border.all(color: const Color.fromARGB(255, 92, 176, 244)),
                      borderRadius:const BorderRadius.all(Radius.circular(20)),
                    ) ,
                    child: GestureDetector(
                      child:const Center(
                        child: Text(
                          "Experiences",style: TextStyle(color: Color.fromARGB(255, 92, 176, 244)),),
                          ),
                          onTap: (){

                          },
                    ),
                   ),
                 ),
                              
              ],),
            ),
          ),
          Expanded (
            child: Container(
              height: 115,
            decoration:  BoxDecoration(
              color: Colors.blue[100],
              borderRadius:const BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40))
            ),
            child:   Padding(
              padding:  const EdgeInsets.only(left: 20,top: 20,right: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Price",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Text("₹${widget.imagePackageDetails.packagePrize}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow:  const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(5.0, 5.0) 
                          )
                        ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                      ),
                      
                      height: 50,
                      width: 100,
                      child: TextButton(
                        onPressed: (){},
                        child: const Center(child: Text("Book Now",style: TextStyle(fontWeight: FontWeight.w800),)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ),
          )
        ],
      ),
    );
  }
}