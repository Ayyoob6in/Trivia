import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/screens/screen_adminrelated/screen_add_package.dart';
import 'package:travel_app/screens/screen_userrelated/screen_package_related.dart';
import 'package:travel_app/screens/login_signup/screen_login.dart';
import 'package:travel_app/screens/models/allmodels.dart';
import 'package:travel_app/utils/lists.dart';

class ScreenAdmin extends StatefulWidget {
  const ScreenAdmin({super.key});

  @override
  State<ScreenAdmin> createState() => _ScreenAdminState();
}

class _ScreenAdminState extends State<ScreenAdmin> {
int selectedChipIndex = 0;
late List<bool> isIconChangedList;
List<bool> isSelected = List.generate(7, (index) => false);


  @override
  void initState() {
    super.initState();
    setState(() {
      selectedChipIndex = 0;
      isSelected = List.generate(chipLabels.length, (i) => i == 0);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 22, right: 20),
            child: Text(
              'Trivia',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color.fromARGB(141, 106, 198, 240)])),
          child: ListView(
            children: [
              drawerSection(
                icon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, size: 20, color: Colors.white),
                ),
                bgcolor: Colors.lightBlueAccent,
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20, color: Colors.white),
                ),
                text: const Text('Add Packages'),
                bgcolor: Colors.green,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddPackages()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.view_array, size: 20, color: Colors.white),
                ),
                text: const Text('Show all Packages'),
                bgcolor: Colors.pink,
                ontap: () {
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AllPackages(imageUrl:ImageDetails(imageUrl[selectedChipIndex][index], imagepackageDetails, , packagePrize) , placeName: placeName)));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, size: 20, color: Colors.white),
                ),
                text: const Text('Logout'),
                bgcolor: Colors.grey,
                ontap: () {
                   _showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15 , right: 15),
        child: Column(
              
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Live your life', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            const Row(
              children: [
                Text('By a ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                Text('compass ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.blue)),
                Text('not a clock', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15 )),
                suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 28)),
                hintText: 'search here',
              ),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height*.08,
               child: ListView(
                scrollDirection: Axis.horizontal,
                 children: List<Widget>.generate(
                   chipLabels.length, (index) =>  Padding(
                     padding:const EdgeInsets.only(left: 5,top: 5),
                     child: ActionChip(
                       label:Text(chipLabels[index],style: TextStyle(color: isSelected[index]?Colors.white : Colors.black,),
                       ),
                       backgroundColor: isSelected[index]?Colors.purple[300]: Colors.blue[200],
                     onPressed: () {
                      
                      setState(() {
                        if(index==0){
                        isSelected=List.generate(chipLabels.length, (i) => i==0) ;
                        selectedChipIndex=0;
                      }else{
                        selectedChipIndex=index;
                        isSelected=List.generate(chipLabels.length, (i) => i==index) ;
                      }
                      });
                      
                     },
                     ),
                   ),
                   ),
               ),
             ),
             
              Expanded(
                child: GridView.builder( 
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                    ),
                    itemCount:imageUrl[selectedChipIndex].length ,
                itemBuilder: (context, index) {
                 return Stack(
                 fit: StackFit.passthrough,
                 children: [ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PackageDetails(details: ImageDetails(
                          imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index]
                          ),
                         currentIndex: index,
                         imagePackageDetails:ImageDetails(
                          imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index]
                               
                          ), 
                          packageInformation: ImageDetails(
                          imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index]             
                           ) ,
                           packagePrize: ImageDetails(
                            imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index] 
                           ),
                           ),
                           ),
                           );
                    },
                    child: Image.network(imageUrl[selectedChipIndex][index],fit: BoxFit.cover,))
                   ),
                   Positioned(
                     bottom: 10,
                     left: 5 ,
                     child:Text(imagepackagDetails[selectedChipIndex][index],
                     style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w200 
                     ),)
                     ),
                   ]
                 );
                },
                ),
                
              ),
             const SizedBox(height: 10,) 
              
          ], 
        ),
      ),
    );
  }

  Future<void> _logout() async {
    Navigator.of(context as BuildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
  }

  Future<void>_showAlertDialog(BuildContext context)async{
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black45,
        title:const Text("Are you sure ?",style: TextStyle(
          fontWeight: FontWeight.w500,color: Colors.white
        ),),
       actions: [
        TextButton(onPressed: (){
         Navigator.of(context).pop();
        }, child:const Text("No")),
        TextButton(onPressed: ()async{
         final sharedprefs = await SharedPreferences.getInstance();
         await sharedprefs.clear();
         _logout();
        }, child:const Text("Yes",style: TextStyle(
          color: Colors.red
        ),))
       ],
      );
    });
  }

  Widget drawerSection({
    required IconButton icon,
    Text? text,
    required Color bgcolor,
    void Function()? ontap,
  }) {
    return ListTile(
      onTap: ontap,
      leading: CircleAvatar(
        backgroundColor: bgcolor,
        radius: 18,
        child: icon,
      ),
      title: text,
    );
  } 
 
}
  
 
