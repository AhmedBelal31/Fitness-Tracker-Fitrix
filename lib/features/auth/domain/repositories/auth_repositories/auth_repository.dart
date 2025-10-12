import 'package:dartz/dartz.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../data/models/params/login_params.dart';
import '../../../data/models/login_response_model.dart';
import '../../../data/models/params/register_params.dart';
import '../../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> register(RegisterParams params);
  Future<Either<Failure, LoginResponseModel>> login(LoginParams params);
  Future<Either<Failure, void>> forgotPassword(String email);
}
