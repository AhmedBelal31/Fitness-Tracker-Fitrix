import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/section_model.dart';
import '../../data/models/exercise_model.dart';
import '../../data/models/custom_exercise_request.dart';
import '../../data/models/section_group_model.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, List<SectionModel>>> getSections();

  Future<Either<Failure, List<ExerciseModel>>> getExercisesBySection({
    required String sectionId,
    String? searchTerm,
    String? difficulty,
  });

  Future<Either<Failure, List<ExerciseModel>>> getCustomExercises({
    String? difficulty,
  });

  Future<Either<Failure, ExerciseModel>> createCustomExercise(
    CreateCustomExerciseRequest request,
  );

  Future<Either<Failure, bool>> updateCustomExercise(
    String exerciseId,
    String sectionId,
    UpdateCustomExerciseRequest request,
  );

  Future<Either<Failure, bool>> deleteCustomExercise(String exerciseId);

  Future<Either<Failure, SectionGroupModel>> createSectionGroup({
    required String sectionId,
    required String name,
    String? description,
  });

  Future<Either<Failure, List<SectionGroupModel>>> getAllSectionGroups(
    String sectionId,
  );

  Future<Either<Failure, SectionGroupModel>> addExerciseToSectionGroup({
    required String groupId,
    String? exerciseId,
    String? customExerciseId,
  });

  Future<ExerciseModel?> getExerciseById(String exerciseId);
  Future<ExerciseModel?> getCustomExerciseById(String customExerciseId);
}
