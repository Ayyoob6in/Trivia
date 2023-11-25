class Experience{
  int? id;
  int? packageId;
  String name;
  String experiences;
  String totalExpences;
  String image;

  Experience({
    this.id,
    required this. packageId,
    required this.name,
    required this.experiences,
    required this.totalExpences,
    required this.image,
  });
  
  factory Experience.fromMap(Map<String,dynamic>map){
  return Experience(
      id: map["id"],
      packageId: map["packageId"],
      name: map["name"], 
      experiences: map["experiences"],
      totalExpences:map ["totalExpences"],
      image: map["image"],
    );
  }
  Map<String,dynamic>toMap(){
    return {
      "id":id,
      "packageId":packageId,
      "name":name,
      "experiences":experiences,
      "totalExpences":totalExpences,
      "image":image,
    };
  }

}