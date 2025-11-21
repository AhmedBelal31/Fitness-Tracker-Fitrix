class BodyProgressModel {
  final double currentWeight;
  final double? startWeight;
  final double? weightChange;
  final double? currentBodyFat;
  final double? startBodyFat;
  final double? bodyFatChange;
  final double? muscleMassChange;

  BodyProgressModel({
    required this.currentWeight,
    this.startWeight,
    this.weightChange,
    this.currentBodyFat,
    this.startBodyFat,
    this.bodyFatChange,
    this.muscleMassChange,
  });

  factory BodyProgressModel.fromJson(Map<String, dynamic> json) {
    return BodyProgressModel(
      currentWeight: (json['currentWeight'] ?? 0).toDouble(),
      startWeight: json['startWeight'] != null
          ? (json['startWeight'] as num).toDouble()
          : null,
      weightChange: json['weightChange'] != null
          ? (json['weightChange'] as num).toDouble()
          : null,
      currentBodyFat: json['currentBodyFat'] != null
          ? (json['currentBodyFat'] as num).toDouble()
          : null,
      startBodyFat: json['startBodyFat'] != null
          ? (json['startBodyFat'] as num).toDouble()
          : null,
      bodyFatChange: json['bodyFatChange'] != null
          ? (json['bodyFatChange'] as num).toDouble()
          : null,
      muscleMassChange: json['muscleMassChange'] != null
          ? (json['muscleMassChange'] as num).toDouble()
          : null,
    );
  }
}
