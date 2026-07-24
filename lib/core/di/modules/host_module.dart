import '../../../features/host/presentation/cubits/host_cubit.dart';
import '../get_it.dart';

void setupHostModule() {
  // Register HostCubit
  di.registerFactory<HostCubit>(() => HostCubit());
}
