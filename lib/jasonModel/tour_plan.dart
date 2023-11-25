class TourPlan {
  final int? planId; // Use int? if planId is nullable
  final String name;
  final String age;
  final String gender;
  final String placeName;
  final String date;

  TourPlan({
    this.planId,
    required this.name,
    required this.age,
    required this.gender,
    required this.placeName,
    required this.date,
  });

  // Convert TourPlan object to a map
  Map<String, dynamic> toMap() {
    return {
      'planId': planId,
      'name': name,
      'age': age,
      'gender': gender,
      'placeName': placeName,
      'date': date,
    };
  }

  // Create a TourPlan object from a map
  factory TourPlan.fromMap(Map<String, dynamic> map) {
    return TourPlan(
      planId: map['planId'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      placeName: map['placeName'],
      date: map['date'],
    );
  }
}
