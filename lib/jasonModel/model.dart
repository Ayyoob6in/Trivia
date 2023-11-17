class PackageModel {
  final int? packageId;
  final List <String> chipLabels;
  final List <List<String>> imageUrl;
  final List <List<String>> imagePackageDetails;
  final List <List<String>> packageDetails;
  final List <List<String>> packageprize;

  PackageModel({
   this.packageId,
  required this.chipLabels,
  required this.imageUrl,
  required this.imagePackageDetails,
  required this.packageDetails,
  required this.packageprize,


  });

  factory PackageModel.fromMap(Map<String, dynamic> json) => PackageModel(
   packageId: json["packageId"],
   chipLabels: List<String>.from(json["chipLabels"]),
   imageUrl:  (json["imageUrl"] as List)
              .map((item) => List<String>.from(item))
              .toList(), 
   imagePackageDetails: (json["imagePackageDetails"] as List)
              .map((item) => List<String>.from(item))
              .toList(), 
   packageDetails: (json["packageDetails"] as List)
              .map((item) => List<String>.from(item))
              .toList(),
   packageprize: (json["packageprize"] as List)
              .map((item) => List<String>.from(item))
              .toList(),     
  );

  Map<String, dynamic> toMap() => {
       "packageId":packageId,
       "chipLabels":chipLabels,
       "imageUrl":imageUrl,
       "imagePackageDetails":imagePackageDetails,
       "packageDetails":packageDetails,
       "packageprize":packageprize,
      };
}