abstract class SoundState {}

class SoundInitial extends SoundState {}

class SoundLoading extends SoundState {}

class SoundLoaded extends SoundState {
  final bool isEnabled;

  SoundLoaded({required this.isEnabled});
}

class SoundError extends SoundState {
  final String message;

  SoundError(this.message);
}
