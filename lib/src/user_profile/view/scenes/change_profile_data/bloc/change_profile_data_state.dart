part of 'change_profile_data_bloc.dart';

class ChangeProfileDataState extends Equatable {
  const ChangeProfileDataState({
    this.userEntity,
    this.submitting,
    this.success,
    this.nameChangePageStatus,
    this.name = const NonEmptyField.pure(),
    this.surname = const NonEmptyField.pure(),
    this.nationality = const NonEmptyField.pure(),
    this.userName = const NonEmptyField.pure(),
    this.changed,
    this.usernameChangePageStatus,
    this.nationalityChangePageStatus,
  });

  final User userEntity;
  final NonEmptyField name;
  final NonEmptyField surname;
  final NonEmptyField nationality;
  final NonEmptyField userName;
  final bool submitting;
  final bool success;
  final FormzStatus nameChangePageStatus;
  final FormzStatus usernameChangePageStatus;
  final FormzStatus nationalityChangePageStatus;
  final bool changed;

  ChangeProfileDataState copyWith({
    NonEmptyField name,
    NonEmptyField surname,
    NonEmptyField nationality,
    NonEmptyField userName,
    bool submitting,
    bool success,
    bool changed,
    FormzStatus nameChangePageStatus,
    FormzStatus usernameChangePageStatus,
    FormzStatus nationalityChangePageStatus,
    User userEntity,
  }) {
    return new ChangeProfileDataState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      submitting: submitting ?? this.submitting,
      success: success ?? this.success,
      nameChangePageStatus: nameChangePageStatus ?? this.nameChangePageStatus,
      usernameChangePageStatus: usernameChangePageStatus ?? this.usernameChangePageStatus,
      nationalityChangePageStatus: nationalityChangePageStatus ?? this.nationalityChangePageStatus,
      userEntity: userEntity ?? this.userEntity,
      nationality: nationality ?? this.nationality,
      userName: userName ?? this.userName,
      changed: changed ?? this.changed,
    );
  }

  getCurrentPageStatus(ChangeProfileType type) {
    if (type == ChangeProfileType.NAME) {
      return this.nameChangePageStatus;
    } else if (type == ChangeProfileType.USERNAME) {
      return this.usernameChangePageStatus;
    } else if (type == ChangeProfileType.NATIONALITY) {
      return this.nationalityChangePageStatus;
    }
  }

  @override
  List<Object> get props =>
      [
        name,
        surname,
        submitting,
        success,
        nameChangePageStatus,
        usernameChangePageStatus,
        userEntity,
        nationality,
        userName,
        changed,
        nationalityChangePageStatus
      ];
}
