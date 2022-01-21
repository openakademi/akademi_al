part of 'classrooms_bloc.dart';

abstract class ClassroomsEvent extends Equatable {
  const ClassroomsEvent();
}

class LoadClassrooms extends ClassroomsEvent {
  @override
  List<Object> get props => [];
}
