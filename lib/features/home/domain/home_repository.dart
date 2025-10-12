import 'package:dartz/dartz.dart';
import '../../../core/networking/error/failures.dart';
import '../data/dashboard_model.dart';
import '../data/trainee_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, DashboardModel>> getUserDashboard();
  Future<Either<Failure, List<TraineeModel>>> getTrainees();
  Future<Either<Failure, DashboardModel>> getTraineeDashboard(String traineeId);
}
