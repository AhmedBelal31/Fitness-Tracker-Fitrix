import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/sound_service.dart';
import 'sound_state.dart';

class SoundCubit extends Cubit<SoundState> {
  final SoundService _soundService;

  SoundCubit(this._soundService) : super(SoundInitial()) {
    loadSoundSettings();
  }

  Future<void> loadSoundSettings() async {
    try {
      emit(SoundLoading());
      final isEnabled = _soundService.isSoundEnabled;
      emit(SoundLoaded(isEnabled: isEnabled));
    } catch (e) {
      emit(SoundError('Failed to load sound settings'));
    }
  }

  Future<bool> toggleSound(bool currentValue) async {
    try {
      emit(SoundLoading());

      final newValue = !currentValue;

      // ✅ Add delay to see loading animation (600ms)
      await Future.wait([
        _soundService.setSoundEnabled(newValue),
        Future.delayed(const Duration(milliseconds: 600)),
      ]);

      emit(SoundLoaded(isEnabled: newValue));
      return newValue;
    } catch (e) {
      emit(SoundError('Failed to toggle sound'));
      await loadSoundSettings();
      return currentValue;
    }
  }
}
