import 'package:get_it/get_it.dart';
import 'modules/auth_module.dart';
import 'modules/core_module.dart';

final di = GetIt.instance;

Future<void> setupServiceLocator() async {
  setupCoreModule();
  setupAuthModule();
}
