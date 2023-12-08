import 'package:flutter/material.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/tour_plan.dart';
import 'package:travel_app/screens/screen_userrelated/home_screen.dart';
import 'package:travel_app/screens/screen_userrelated/screen_edit_plans.dart';

class ScreePlannedPackages extends StatefulWidget {
  const ScreePlannedPackages({super.key});

  @override
  State<ScreePlannedPackages> createState() => _ScreePlannedPackagesState();
}

class _ScreePlannedPackagesState extends State<ScreePlannedPackages> {
   List<TourPlan> _tourPlan=[];
   
   
   fetchAllPlans() async {
    List<TourPlan> tourPlans = await DatabaseHelper().getallPlans();
    setState(() {
      _tourPlan = tourPlans;
    });
    
}

  delete(int planId)async{
    await DatabaseHelper().deletePlan(planId);
    fetchAllPlans();
  }

   @override
  void initState() {
    super.initState();
       fetchAllPlans();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Text("Planned Packages"),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17,),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body:
      _tourPlan.isEmpty ? const Center(child: Text("No Planned Packages Avilable 🙂"),)
      :
       Container(
        color: Colors.white,
         child: ListView.builder(
          itemCount: _tourPlan.length,
          itemBuilder: (context,index){
          TourPlan tourPlan =_tourPlan[index];
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            child: Container(
              decoration: BoxDecoration(
               border: Border.all(color: Colors.white),
               borderRadius: BorderRadius.circular(20),
               color: Colors.blue[100],
               boxShadow: const [
                BoxShadow(
                   blurRadius: 10,
                color: Colors.blue
                )
               ]
              ),
              height: MediaQuery.of(context).size.height*0.2,
              child: 
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    Text("Destination: ${tourPlan.placeName}",style: const TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black
                    ),),
                    Text("Name:  ${tourPlan.name}",style: const TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black
                    ),),
                    Text("Age:  ${tourPlan.age}",style: const TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black
                    ),),
                    Text("Gender:  ${tourPlan.gender}",style: const TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black
                    ),),
                    Text("Date:  ${tourPlan.date}",style: const TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black
                    ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      IconButton(
                        onPressed: ()async{ 
                        TourPlan updatedPlan=await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>ScreenEditPlans(editTourPlan: tourPlan))
                        );
                        debugPrint('Updated PLan Name: ${updatedPlan.name}');
                      },
                       icon: const Icon(Icons.edit)),
                      IconButton(onPressed: (){
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
                delete(tourPlan.planId!);
                Navigator.of(context).pop();
              },
              child: const Text("Delete",style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
                      }, icon: const Icon(Icons.delete,color: Colors.red,))
                    ],)

                    
                ],),
              )
              ,)
          );
          }
          ),
       )

      );
  }
  Future<TourPlan>navigateToEditPlan(TourPlan tourPlan)async{
    TourPlan? updatePlan=await Navigator.of(context).push<TourPlan>(
      MaterialPageRoute(builder: (context)=>ScreenEditPlans(editTourPlan: tourPlan)
      ),
    );
    return updatePlan ?? tourPlan;
  }
  
}