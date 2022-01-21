part of 'synchronization_bloc.dart';

enum SynchronizationProcessState {not_started, started, finished}

abstract class SynchronizationEvent extends Equatable {
  const SynchronizationEvent();

  @override
  List<Object> get props => [];
}

class SynchronizationStart extends SynchronizationEvent {}


class DeleteSynchronization extends SynchronizationEvent {}