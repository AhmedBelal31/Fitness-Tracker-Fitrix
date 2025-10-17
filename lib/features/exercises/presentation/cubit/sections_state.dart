import 'package:equatable/equatable.dart';
import '../../data/models/section_model.dart';

abstract class SectionsState extends Equatable {
  const SectionsState();

  @override
  List<Object?> get props => [];
}

class SectionsInitial extends SectionsState {}

class SectionsLoading extends SectionsState {}

class SectionsLoaded extends SectionsState {
  final List<SectionModel> sections;

  const SectionsLoaded(this.sections);

  @override
  List<Object?> get props => [sections];
}

class SectionsError extends SectionsState {
  final String message;

  const SectionsError(this.message);

  @override
  List<Object?> get props => [message];
}
