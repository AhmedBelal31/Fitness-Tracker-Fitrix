// class MeasurementCardsResponse {
//   final WeightCard weightCard;
//   final BodyFatCard bodyFatCard;
//   final MuscleMassCard muscleMassCard;
//
//   MeasurementCardsResponse({
//     required this.weightCard,
//     required this.bodyFatCard,
//     required this.muscleMassCard,
//   });
//
//   factory MeasurementCardsResponse.fromJson(Map<String, dynamic> json) {
//     return MeasurementCardsResponse(
//       weightCard: WeightCard.fromJson(json['weightCard']),
//       bodyFatCard: BodyFatCard.fromJson(json['bodyFatCard']),
//       muscleMassCard: MuscleMassCard.fromJson(json['muscleMassCard']),
//     );
//   }
// }
//
// class WeightCard {
//   final double firstWeight;
//   final double lastWeight;
//   final double weightGoal;
//   final double weightLost;
//
//   WeightCard({
//     required this.firstWeight,
//     required this.lastWeight,
//     required this.weightGoal,
//     required this.weightLost,
//   });
//
//   factory WeightCard.fromJson(Map<String, dynamic> json) {
//     return WeightCard(
//       firstWeight: (json['firstWeight'] as num).toDouble(),
//       lastWeight: (json['lastWeight'] as num).toDouble(),
//       weightGoal: (json['weightGoal'] as num).toDouble(),
//       weightLost: (json['weightLost'] as num).toDouble(),
//     );
//   }
// }
//
// class BodyFatCard {
//   final double firstBodyFat;
//   final double lastBodyFat;
//   final double bodyFatGoal;
//   final double bodyFatLost;
//
//   BodyFatCard({
//     required this.firstBodyFat,
//     required this.lastBodyFat,
//     required this.bodyFatGoal,
//     required this.bodyFatLost,
//   });
//
//   factory BodyFatCard.fromJson(Map<String, dynamic> json) {
//     return BodyFatCard(
//       firstBodyFat: (json['firstBodyFat'] as num).toDouble(),
//       lastBodyFat: (json['lastBodyFat'] as num).toDouble(),
//       bodyFatGoal: (json['bodyFatGoal'] as num).toDouble(),
//       bodyFatLost: (json['bodyFatLost'] as num).toDouble(),
//     );
//   }
// }
//
// class MuscleMassCard {
//   final double firstMuscleMass;
//   final double lastMuscleMass;
//   final double muscleMassGoal;
//   final double muscleMassGained;
//
//   MuscleMassCard({
//     required this.firstMuscleMass,
//     required this.lastMuscleMass,
//     required this.muscleMassGoal,
//     required this.muscleMassGained,
//   });
//
//   factory MuscleMassCard.fromJson(Map<String, dynamic> json) {
//     return MuscleMassCard(
//       firstMuscleMass: (json['firstMuscleMass'] as num).toDouble(),
//       lastMuscleMass: (json['lastMuscleMass'] as num).toDouble(),
//       muscleMassGoal: (json['muscleMassGoal'] as num).toDouble(),
//       muscleMassGained: (json['muscleMassGained'] as num).toDouble(),
//     );
//   }
// }
//
// // Enum for card types
// enum MeasurementCardType { weight, bodyFat, muscleMass }
class MeasurementCardsResponse {
  final WeightCard weightCard;
  final BodyFatCard bodyFatCard;
  final MuscleMassCard muscleMassCard;

  MeasurementCardsResponse({
    required this.weightCard,
    required this.bodyFatCard,
    required this.muscleMassCard,
  });

  factory MeasurementCardsResponse.fromJson(Map<String, dynamic> json) {
    return MeasurementCardsResponse(
      weightCard: WeightCard.fromJson(json['weightCard']),
      bodyFatCard: BodyFatCard.fromJson(json['bodyFatCard']),
      muscleMassCard: MuscleMassCard.fromJson(json['muscleMassCard']),
    );
  }
}

class WeightCard {
  final double firstWeight;
  final double lastWeight;
  final double? weightGoal; // Made nullable
  final double weightGained; // Changed from weightLost to weightGained

  WeightCard({
    required this.firstWeight,
    required this.lastWeight,
    this.weightGoal,
    required this.weightGained,
  });

  factory WeightCard.fromJson(Map<String, dynamic> json) {
    return WeightCard(
      firstWeight: (json['firstWeight'] as num?)?.toDouble() ?? 0.0,
      lastWeight: (json['lastWeight'] as num?)?.toDouble() ?? 0.0,
      weightGoal: (json['weightGoal'] as num?)?.toDouble(), // Allow null
      weightGained:
          (json['weightGained'] as num?)?.toDouble() ?? 0.0, // Changed key
    );
  }

  // Helper getter for weight lost (if needed)
  double get weightLost => -weightGained;
}

class BodyFatCard {
  final double firstBodyFat;
  final double lastBodyFat;
  final double? bodyFatGoal; // Made nullable
  final double bodyFatGained; // Changed from bodyFatLost to bodyFatGained

  BodyFatCard({
    required this.firstBodyFat,
    required this.lastBodyFat,
    this.bodyFatGoal,
    required this.bodyFatGained,
  });

  factory BodyFatCard.fromJson(Map<String, dynamic> json) {
    return BodyFatCard(
      firstBodyFat: (json['firstBodyFat'] as num?)?.toDouble() ?? 0.0,
      lastBodyFat: (json['lastBodyFat'] as num?)?.toDouble() ?? 0.0,
      bodyFatGoal: (json['bodyFatGoal'] as num?)?.toDouble(), // Allow null
      bodyFatGained:
          (json['bodyFatGained'] as num?)?.toDouble() ?? 0.0, // Changed key
    );
  }

  double get bodyFatLost => -bodyFatGained;
}

class MuscleMassCard {
  final double firstMuscleMass;
  final double lastMuscleMass;
  final double? muscleMassGoal;
  final double muscleMassGained;

  MuscleMassCard({
    required this.firstMuscleMass,
    required this.lastMuscleMass,
    this.muscleMassGoal,
    required this.muscleMassGained,
  });

  factory MuscleMassCard.fromJson(Map<String, dynamic> json) {
    return MuscleMassCard(
      firstMuscleMass: (json['firstMuscleMass'] as num?)?.toDouble() ?? 0.0,
      lastMuscleMass: (json['lastMuscleMass'] as num?)?.toDouble() ?? 0.0,
      muscleMassGoal: (json['muscleMassGoal'] as num?)
          ?.toDouble(), // Allow null
      muscleMassGained: (json['muscleMassGained'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

enum MeasurementCardType { weight, bodyFat, muscleMass }
