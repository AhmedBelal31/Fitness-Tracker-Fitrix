import 'package:dartz/dartz.dart';
import '../../../core/networking/error/failures.dart';
import '../data/achievements_models.dart';

abstract class AchievementsRepository {
  Future<Either<Failure, AchievementsResponse>> getAchievements();
}
