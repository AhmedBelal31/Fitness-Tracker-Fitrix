import 'package:equatable/equatable.dart';

import '../../../../generated/l10n.dart';

class MeasurementChartResponse extends Equatable {
  final List<ChartDataPoint> weightChart;
  final List<ChartDataPoint> bodyFatChart;
  final List<ChartDataPoint> muscleMassChart;

  const MeasurementChartResponse({
    required this.weightChart,
    required this.bodyFatChart,
    required this.muscleMassChart,
  });

  factory MeasurementChartResponse.fromJson(Map<String, dynamic> json) {
    return MeasurementChartResponse(
      weightChart: (json['weightChart'] as List)
          .map((e) => ChartDataPoint.fromJson(e))
          .where((point) => point.value != null)
          .toList(),
      bodyFatChart: (json['bodyFatChart'] as List)
          .map((e) => ChartDataPoint.fromJson(e))
          .where((point) => point.value != null)
          .toList(),
      muscleMassChart: (json['muscleMassChart'] as List)
          .map((e) => ChartDataPoint.fromJson(e))
          .where((point) => point.value != null)
          .toList(),
    );
  }

  @override
  List<Object?> get props => [weightChart, bodyFatChart, muscleMassChart];
}

class ChartDataPoint extends Equatable {
  final DateTime date;
  final double? value;

  const ChartDataPoint({required this.date, this.value});

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      date: DateTime.parse(json['date']),
      value: json['value'] is int
          ? (json['value'] as int).toDouble()
          : json['value'] as double?,
    );
  }

  @override
  List<Object?> get props => [date, value];
}

enum ChartType { line, bar, area }

enum TimePeriod {
  week(7, 'period_7_days'),
  month(30, 'period_30_days'),
  threeMonths(90, 'period_90_days'),
  sixMonths(180, 'period_6_months'),
  year(365, 'period_1_year');

  final int days;
  final String labelKey; // ✅ Now stores localization key
  const TimePeriod(this.days, this.labelKey);

  // ✅ Helper to get localized label
  String getLabel(S s) {
    switch (this) {
      case TimePeriod.week:
        return s.period_7_days;
      case TimePeriod.month:
        return s.period_30_days;
      case TimePeriod.threeMonths:
        return s.period_90_days;
      case TimePeriod.sixMonths:
        return s.period_6_months;
      case TimePeriod.year:
        return s.period_1_year;
    }
  }
}
