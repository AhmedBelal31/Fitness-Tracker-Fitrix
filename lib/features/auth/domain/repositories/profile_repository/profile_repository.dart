import 'package:dartz/dartz.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../data/models/login_profile_model.dart';
import '../../../data/models/params/complete_profile_params.dart';
import '../../../data/models/params/update_profile_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, LoginProfileModel>> completeProfile(
    CompleteProfileParams params,
  );

  Future<Either<Failure, LoginProfileModel>> getProfile();

  Future<Either<Failure, LoginProfileModel>> updateProfile(
    UpdateProfileParams params,
  );
}
