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
  final double weightGoal;
  final double weightLost;

  WeightCard({
    required this.firstWeight,
    required this.lastWeight,
    required this.weightGoal,
    required this.weightLost,
  });

  factory WeightCard.fromJson(Map<String, dynamic> json) {
    return WeightCard(
      firstWeight: (json['firstWeight'] as num).toDouble(),
      lastWeight: (json['lastWeight'] as num).toDouble(),
      weightGoal: (json['weightGoal'] as num).toDouble(),
      weightLost: (json['weightLost'] as num).toDouble(),
    );
  }
}

class BodyFatCard {
  final double firstBodyFat;
  final double lastBodyFat;
  final double bodyFatGoal;
  final double bodyFatLost;

  BodyFatCard({
    required this.firstBodyFat,
    required this.lastBodyFat,
    required this.bodyFatGoal,
    required this.bodyFatLost,
  });

  factory BodyFatCard.fromJson(Map<String, dynamic> json) {
    return BodyFatCard(
      firstBodyFat: (json['firstBodyFat'] as num).toDouble(),
      lastBodyFat: (json['lastBodyFat'] as num).toDouble(),
      bodyFatGoal: (json['bodyFatGoal'] as num).toDouble(),
      bodyFatLost: (json['bodyFatLost'] as num).toDouble(),
    );
  }
}

class MuscleMassCard {
  final double firstMuscleMass;
  final double lastMuscleMass;
  final double muscleMassGoal;
  final double muscleMassGained;

  MuscleMassCard({
    required this.firstMuscleMass,
    required this.lastMuscleMass,
    required this.muscleMassGoal,
    required this.muscleMassGained,
  });

  factory MuscleMassCard.fromJson(Map<String, dynamic> json) {
    return MuscleMassCard(
      firstMuscleMass: (json['firstMuscleMass'] as num).toDouble(),
      lastMuscleMass: (json['lastMuscleMass'] as num).toDouble(),
      muscleMassGoal: (json['muscleMassGoal'] as num).toDouble(),
      muscleMassGained: (json['muscleMassGained'] as num).toDouble(),
    );
  }
}

// Enum for card types
enum MeasurementCardType { weight, bodyFat, muscleMass }
