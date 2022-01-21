part of 'change_profile_data_bloc.dart';

class ChangeProfileDataEvent extends Equatable {
  const ChangeProfileDataEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEntity extends ChangeProfileDataEvent {
  final User userEntity;

  LoadUserEntity({this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

class ChangeName extends ChangeProfileDataEvent {
  final String newName;

  ChangeName({this.newName});

  @override
  List<Object> get props => [newName];
}

class ChangeSurname extends ChangeProfileDataEvent {
  final String surname;

  ChangeSurname({this.surname});

  @override
  List<Object> get props => [surname];
}

class ChangeUsername extends ChangeProfileDataEvent {
  final String username;

  ChangeUsername({this.username});

  @override
  List<Object> get props => [username];
}

class ChangeNationality extends ChangeProfileDataEvent {
  final String nationality;

  ChangeNationality({this.nationality});

  @override
  List<Object> get props => [nationality];
}

class RequestChangeNameAndSurname extends ChangeProfileDataEvent{

}

class RequestChangeUsername extends ChangeProfileDataEvent{

}