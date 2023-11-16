class PackageModel {
  final int? packageId;
  final List <String> chipLabels;
  final List <String> imageUrl;
  final List <String> imagePackageDetails;
  final List <String> packageDetails;
  final List <String> packageprize;

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
   chipLabels: json["chipLabels"],
   imageUrl: json["imageUrl"],
   imagePackageDetails: json["imagePackageDetails"],
   packageDetails: json["packageDetails"],
   packageprize: json["packagePrize"],     
  );

  Map<String, dynamic> toMap() => {
       "packageId":packageId,
       "chipLabels":chipLabels,
       "imageUrl":imageUrl.join(','),
       "imagePackageDetails":imagePackageDetails,
       "packageDetails":packageDetails,
       "packageprize":packageprize,
      };
}