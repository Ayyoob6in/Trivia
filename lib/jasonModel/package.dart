class Package {
  final int? packageId;
  final String category;
  final String imageUrl;
  final String name;
  final String description;
  final String prize;

  Package({
   this.packageId,
   required this.category, 
   required this.imageUrl, 
   required this.name, 
   required this.description, 
   required this.prize,
   });

   factory Package.fromMap(Map<String,dynamic> map){
   return Package(
    packageId: map["packageId"],
    category: map["category"],
    imageUrl: map["imageUrl"],
    name: map["name"], 
    description: map["description"],
    prize: map["prize"]
    );
   }

   Map<String,dynamic> toMap(){
    
    return {
      "packageId":packageId,
      "category":category,
      "imageUrl":imageUrl,
      "name":name,
      "description":description,
      "prize":prize
    };
    
   }


  
}