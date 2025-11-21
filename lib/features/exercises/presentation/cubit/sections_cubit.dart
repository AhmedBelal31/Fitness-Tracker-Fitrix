import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/exercise_repository.dart';
import 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  final ExerciseRepository _repository;

  SectionsCubit(this._repository) : super(SectionsInitial());

  Future<void> loadSections() async {
    emit(SectionsLoading());

    final result = await _repository.getSections();

    result.fold(
      (failure) => emit(SectionsError(failure.errorMessage)),
      (sections) => emit(SectionsLoaded(sections)),
    );
  }
}
