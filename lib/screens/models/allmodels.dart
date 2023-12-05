class ImageDetails{
  final String imageUrl;
  final String imagepackageDetails;
  final String packageInformation;
  final String packagePrize;
  ImageDetails(this.imageUrl,this.imagepackageDetails,this.packageInformation,this.packagePrize);
  
}

class Pk {
  final String name;
  final String imageUrl;
  final String category;
  final String description; 

  Pk({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.description,
  });
}