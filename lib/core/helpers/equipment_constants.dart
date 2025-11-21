import '../../generated/l10n.dart';

class EquipmentConstants {
  // Store equipment as keys (English)
  static const List<String> equipmentKeys = [
    'barbell',
    'dumbbells',
    'ez_bar',
    'kettlebell',
    'weight_plates',
    'cable_machine',
    'smith_machine',
    'leg_press_machine',
    'chest_press_machine',
    'shoulder_press_machine',
    'lat_pulldown_machine',
    'seated_row_machine',
    'leg_curl_machine',
    'leg_extension_machine',
    'hack_squat_machine',
    'pec_deck_machine',
    'treadmill',
    'stationary_bike',
    'rowing_machine',
    'elliptical_machine',
    'stair_climber',
    'bodyweight',
    'pull_up_bar',
    'dip_station',
    'suspension_trainer',
    'resistance_bands',
    'battle_ropes',
    'medicine_ball',
    'stability_ball',
    'foam_roller',
    'flat_bench',
    'incline_bench',
    'decline_bench',
    'adjustable_bench',
    'squat_rack',
    'power_rack',
    'ab_wheel',
    'plyo_box',
    'slam_ball',
    'sandbag',
    'gymnastic_rings',
    'parallettes',
    'none',
    'other',
  ];

  // Get localized equipment list
  static List<String> getLocalizedEquipment(S s) {
    return [
      // Free Weights
      s.barbell,
      s.dumbbells,
      s.ez_bar,
      s.kettlebell,
      s.weight_plates,

      // Machines
      s.cable_machine,
      s.smith_machine,
      s.leg_press_machine,
      s.chest_press_machine,
      s.shoulder_press_machine,
      s.lat_pulldown_machine,
      s.seated_row_machine,
      s.leg_curl_machine,
      s.leg_extension_machine,
      s.hack_squat_machine,
      s.pec_deck_machine,

      // Cardio Equipment
      s.treadmill,
      s.stationary_bike,
      s.rowing_machine,
      s.elliptical_machine,
      s.stair_climber,

      // Bodyweight & Functional
      s.bodyweight,
      s.pull_up_bar,
      s.dip_station,
      s.suspension_trainer,
      s.resistance_bands,
      s.battle_ropes,
      s.medicine_ball,
      s.stability_ball,
      s.foam_roller,

      // Benches & Racks
      s.flat_bench,
      s.incline_bench,
      s.decline_bench,
      s.adjustable_bench,
      s.squat_rack,
      s.power_rack,

      // Other
      s.ab_wheel,
      s.plyo_box,
      s.slam_ball,
      s.sandbag,
      s.gymnastic_rings,
      s.parallettes,
      s.none,
      s.other_custom,
    ];
  }
}
