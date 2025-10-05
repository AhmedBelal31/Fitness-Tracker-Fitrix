import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/register_params.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> register(RegisterParams params);

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserModel>> getCurrentUser();
}
