import 'package:dartz/dartz.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../data/models/login_profile_model.dart';
import '../../../data/models/params/complete_profile_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, LoginProfileModel>> completeProfile(
    CompleteProfileParams params,
  );
}
