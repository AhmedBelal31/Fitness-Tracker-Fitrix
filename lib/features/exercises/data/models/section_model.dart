class SectionModel {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final int exerciseCount;

  SectionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.exerciseCount,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      iconName: json['iconName'] ?? '',
      exerciseCount: json['exerciseCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconName': iconName,
      'exerciseCount': exerciseCount,
    };
  }
}
