import 'package:get_it/get_it.dart';
import 'modules/auth_module.dart';
import 'modules/core_module.dart';
import 'modules/exercise_module.dart';
import 'modules/host_module.dart';
import 'modules/profile_module.dart';
import 'modules/setup_home_module.dart';
import 'modules/workout_module.dart';

final di = GetIt.instance;

Future<void> setupServiceLocator() async {
  setupCoreModule();
  setupAuthModule();
  setupProfileModule();
  setupHomeModule();
  setupHostModule();
  setupExerciseModule();
  setupWorkoutModule();
}
