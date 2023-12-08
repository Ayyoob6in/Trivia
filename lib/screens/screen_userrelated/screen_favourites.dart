import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:travel_app/jasonModel/package.dart';
import 'package:travel_app/screens/screen_userrelated/home_screen.dart';

class ScreenFavourites extends StatefulWidget {
  const ScreenFavourites({super.key, required this.removeFromFavoritesCallback});
  final void Function(Package) removeFromFavoritesCallback;

  @override
  State<ScreenFavourites> createState() => _ScreenFavouritesState();
}

class _ScreenFavouritesState extends State<ScreenFavourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        title: const Text("Favourites"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
           fontSize: 20, 
           fontWeight: FontWeight.w400,
           ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: packageNotifier,
        builder: (BuildContext context, List<Package> value, Widget? child) {
          if(value.isEmpty){
            return const Center(
              child: Text("No Favourites 🙂",style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w200,
              ),),
            );
          }
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                          )
                        ]
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InstaImageViewer(
                          child: Image.file(
                            File(value[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 7,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value[index].name,
                            style: const TextStyle(
                                color: Colors.white,
                                 fontWeight: FontWeight.w200,
                                 fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            final removedPackage = value[index];
                            packageNotifier.value.remove(removedPackage);
                            saveFavoritesToSharedPreferences(packageNotifier.value);
                            widget.removeFromFavoritesCallback(removedPackage);
                          });
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red, size: 35),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
