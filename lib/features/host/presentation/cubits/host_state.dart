import 'package:equatable/equatable.dart';

class HostState extends Equatable {
  final int currentIndex;

  const HostState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
