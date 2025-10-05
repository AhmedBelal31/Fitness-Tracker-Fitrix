import 'package:dartz/dartz.dart';
import '../../../core/networking/error/failures.dart';
import '../data/models/complete_profile_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> completeProfile(CompleteProfileParams params);
}
