part of 'synchronization_bloc.dart';


class SynchronizationState extends Equatable {
  const SynchronizationState(this.status);

  final SynchronizationProcessState status;
  @override
  List<Object> get props => [status];
}
