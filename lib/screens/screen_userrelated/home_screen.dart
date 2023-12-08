import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/package.dart';
import 'package:travel_app/screens/screen_userrelated/screen_about.dart';
import 'package:travel_app/screens/screen_userrelated/screen_favourites.dart';
import 'package:travel_app/screens/screen_userrelated/screen_package_related.dart';
import 'package:travel_app/screens/login_signup/screen_login.dart';
import 'package:travel_app/screens/screen_userrelated/screen_plan.dart';
import 'package:travel_app/screens/screen_userrelated/screen_planned_packages.dart';
import 'package:travel_app/screens/screen_userrelated/screen_privacy.dart';
import 'package:travel_app/screens/screen_userrelated/screen_weather.dart';
import 'package:travel_app/utils/lists.dart';

ValueNotifier<List<Package>> packageNotifier = ValueNotifier<List<Package>>([]);
const String favoritesKey="favourites";

Future<void> saveFavoritesToSharedPreferences(List<Package> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = favorites.map((favorite) => favorite.toMap()).toList();
    prefs.setStringList(favoritesKey, favoritesJson.map((e) => json.encode(e)).toList());
  }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedChipIndex = 0;
List<bool> isSelected = List.generate(6, (index) => false);
List<Package> packages=[];
List<Package> filterPackage=[];
TextEditingController searchController=TextEditingController();
List<Package>favourites=[];
List<bool>selectedIcon=[];



fetchAllPackages()async{
  packages= await DatabaseHelper().getAllPackages();

  //  List<Package>hardcodedPackages  = [
  //    Package(
  //     category: "Hill station", 
  //     imageUrl: "assets/moon.png",
  //     name: "Munnar",
  //     description: "Munnar, nestled in the Western Ghats of Kerala, India, is a picturesque hill station renowned for its lush tea plantations, mist-covered mountains, and serene landscapes. Visitors are captivated by the aromatic tea gardens, diverse flora, and pleasant climate. Munnar offers a tranquil escape, with attractions like Mattupetty Dam and Eravikulam National Park showcasing its natural beauty.",
  //     prize: "999"
  //     )
      
  //   ];
  //   packages.addAll(hardcodedPackages);
  setState(() {
    filterPackage = List.from(packages);
    selectedIcon=List.generate(packages.length,(index)=>false);
  });
}


void handleSearch(String query) {
  setState(() {
    if (query.isNotEmpty) {
      filterPackage = packages
      .where((package) =>
      package.name.toLowerCase().contains(query.toLowerCase()))
     .toList();
    } else {
      filterPackage = List.from(packages);
    }
  });
}
 
Future<void> loadFavoritesFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final favoritesJson = prefs.getStringList(favoritesKey);
  if (favoritesJson != null) {
    final loadedFavorites = favoritesJson.map((jsonString) => Package.fromMap(json.decode(jsonString))).toList();
    setState(() {
      packageNotifier.value = loadedFavorites;
      selectedIcon = List.generate(packages.length, (index) => loadedFavorites.contains(packages[index]));
    });
        

  }
}

Future<void> saveFavoritesToSharedPreferences(List<Package> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = favorites.map((favorite) => favorite.toMap()).toList();
    prefs.setStringList(favoritesKey, favoritesJson.map((e) => json.encode(e)).toList());
  }
  void removeFromFavorites(Package package) {
  setState(() {
    // Update selectedIcon when a package is removed from favorites
    selectedIcon = List.generate(packages.length, (index) => packageNotifier.value.contains(packages[index]));
  });
}

  @override
  void initState() {
    fetchAllPackages();
    loadFavoritesFromSharedPreferences();
    super.initState();
    setState(() {
     isSelected = List.generate(chipLabels.length, (i) => i==selectedChipIndex);
     selectedChipIndex = 0;
     filterPackage = List.from(packages);
     selectedIcon= List.generate(packages.length, (index) => favourites.contains(packages[index]));
     
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
                  icon: const Icon(Icons.favorite, size: 20, color: Colors.white),
                ),
                text: const Text('Favourites'),
                bgcolor: Colors.pinkAccent,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ScreenFavourites(removeFromFavoritesCallback: removeFromFavorites,)));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_location, size: 20, color: Colors.white),
                ),
                text: const Text('New Tour Plan'),
                bgcolor: Colors.teal,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenPlan()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.travel_explore, size: 20, color: Colors.white),
                ),
                text: const Text('Planned Packages'),
                bgcolor: Colors.redAccent,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreePlannedPackages()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.sunny, size: 20, color: Colors.orange),
                ),
                text: const Text('Weather'),
                bgcolor: Colors.white70,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenWeather()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_search, size: 20, color: Colors.white),
                ),
                text: const Text('About'),
                bgcolor: Colors.black,
                ontap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenAbout()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.privacy_tip, size: 20, color: Colors.white),
                ),
                text: const Text('Privacy Policy'),
                bgcolor: Colors.orange,
                ontap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenPrivacy()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share, size: 20, color: Colors.white),
                ),
                text: const Text('Share'),
                bgcolor: Colors.green,
                ontap: () {
                  Share.share("Check Out My Application"); 
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
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  handleSearch(searchController.text);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15 )),
                suffixIcon: IconButton(onPressed: () {}, 
                icon: const Icon(Icons.search, size: 28)),
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
                      shape:const StadiumBorder(),
                       label:Text(chipLabels[index],style: TextStyle(color: isSelected[index]?Colors.white : Colors.black,),
                       ),
                       backgroundColor: isSelected[index]?Colors.purple[300]: Colors.blue[200],
                     onPressed: () {
                      filterPackage=packages.where((package) => package.category==chipLabels[index]).toList();
                     setState(() {
                        if(index==0){
                        isSelected = List.generate(chipLabels.length, (i) => i == index);
                        filterPackage = List.from(packages); // Show all package
                        selectedChipIndex=index;
                      }else{
                        selectedChipIndex=index;
                        isSelected=List.generate(chipLabels.length, (i) => i==index) ;
                        filterPackage = packages.where((package) => package.category == chipLabels[index]).toList();
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
                    itemCount:filterPackage.length,
                itemBuilder: (context, index) {
                 print(filterPackage[index].imageUrl);
                 //final img=filterPackage[index];
                 return Stack(
                 fit: StackFit.passthrough,
                 children: [ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: InkWell(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PackageDetails(package: filterPackage[index],),),);
                    },
                    child: Image.file(File(filterPackage[index].imageUrl),fit: BoxFit.cover,))
                   ),
                   Positioned(
                     bottom: 10,
                     left: 5 ,
                     child:Text(filterPackage[index].name,
                     style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w200 
                     ),)
                     ),
                          Positioned(
                right: 5,
                bottom: 0,
                child: ValueListenableBuilder<List<Package>>(
                  valueListenable: packageNotifier,
                  builder: (context, packages, _) {
                    return IconButton(
                      onPressed: () {
                       setState(() {
                        final selectedPackage = filterPackage[index];
                        final isAlreadyInFavorites = packageNotifier.value.any((p) => p.name == selectedPackage.name);

                       if (selectedIcon[index]) {
                         // If the item is selected, unselect it and remove from favorites
                         selectedIcon[index] = false;
                          packages.remove(selectedPackage);
                       } else {
                        // If the item is unselected and not already in favorites, add to favorites
                         if (!isAlreadyInFavorites) {
                          selectedIcon[index] = true;
                           packages.add(selectedPackage);
                           }
                        }

                         // Update the ValueNotifier value
                      packageNotifier.value = List.from(packages);
                       saveFavoritesToSharedPreferences(packages);
                    });
                   },
                      icon: selectedIcon[index]
                          ? const Icon(Icons.favorite, color: Colors.red,)
                          : const Icon(Icons.favorite_border, color: Colors.white,),
                    );
                  },
                ),
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
    Navigator.of(context).pushAndRemoveUntil(
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


