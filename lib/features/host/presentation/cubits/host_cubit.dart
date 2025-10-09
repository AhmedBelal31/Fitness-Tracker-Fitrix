import 'package:flutter_bloc/flutter_bloc.dart';
import 'host_state.dart';

class HostCubit extends Cubit<HostState> {
  HostCubit() : super(const HostState(0));

  void changeTab(int index) {
    emit(HostState(index));
  }

  void resetToHome() {
    emit(const HostState(0));
  }
}
