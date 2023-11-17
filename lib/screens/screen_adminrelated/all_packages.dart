import 'package:flutter/material.dart';
import 'package:travel_app/screens/models/allmodels.dart';
class AllPackages extends StatefulWidget {
  const AllPackages({super.key,required this.images,required this.placeNames});
   final List<List<ImageDetails>> images;
  final List<String> placeNames;

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Packages"),
      ),
      body: 
      SingleChildScrollView(
        child: Column(children: [
      
        ],),
      )
      
      ,
    );
  }
}