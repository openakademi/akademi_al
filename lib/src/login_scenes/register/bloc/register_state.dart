part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.firstPageStatus = FormzStatus.pure,
      this.secondPageStatus = FormzStatus.pure,
      this.fourthPageStatus = FormzStatus.pure,
      this.name = const Name.pure(),
      this.surname = const Surname.pure(),
      this.birthday = const Birthday.pure(),
      this.currentIndex = 0,
      this.email = const Email.pure(),
      this.thirdPageStatus = FormzStatus.pure,
      this.username = const Username.pure(),
      this.isUnder13 = false,
      this.password = const Password.pure(),
      this.registrationSuccess = false,
      this.submitting = false,
      this.resendEmail = false,
      this.existingUser});

  final FormzStatus firstPageStatus;
  final FormzStatus secondPageStatus;
  final FormzStatus thirdPageStatus;
  final FormzStatus fourthPageStatus;
  final Name name;
  final Surname surname;
  final Birthday birthday;
  final Email email;
  final int currentIndex;
  final Username username;
  final bool isUnder13;
  final Password password;
  final bool registrationSuccess;
  final bool submitting;
  final bool resendEmail;
  final bool existingUser;

  getPageStatus(int index) {
    switch (index) {
      case 0:
        {
          return firstPageStatus;
        }
      case 1:
        {
          return secondPageStatus;
        }
      case 2:
        {
          return thirdPageStatus;
        }
      case 3:
        {
          return fourthPageStatus;
        }
    }
  }

  RegisterState copyWith(
      {FormzStatus firstPageStatus,
      Name name,
      Surname surname,
      int currentIndex,
      Birthday birthday,
      FormzStatus secondPageStatus,
      Email email,
      FormzStatus thirdPageStatus,
      Username username,
      bool isUnder13,
      Password password,
      FormzStatus fourthPageStatus,
      bool registrationSuccess,
      bool submitting,
      bool resendEmail,
      bool existingUser}) {
    return RegisterState(
      firstPageStatus: firstPageStatus ?? this.firstPageStatus,
      secondPageStatus: secondPageStatus ?? this.secondPageStatus,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      currentIndex: currentIndex ?? this.currentIndex,
      birthday: birthday ?? this.birthday,
      isUnder13: isUnder13 ?? this.isUnder13,
      email: email ?? this.email,
      thirdPageStatus: thirdPageStatus ?? this.thirdPageStatus,
      username: username ?? this.username,
      password: password ?? this.password,
      fourthPageStatus: fourthPageStatus ?? this.fourthPageStatus,
      registrationSuccess: registrationSuccess ?? this.registrationSuccess,
      submitting: submitting ?? this.submitting,
      resendEmail: resendEmail ?? this.resendEmail,
      existingUser: existingUser ?? this.existingUser,
    );
  }

  @override
  List<Object> get props => [
        firstPageStatus,
        secondPageStatus,
        thirdPageStatus,
        name,
        surname,
        currentIndex,
        birthday,
        email,
        username,
        password,
        fourthPageStatus,
        registrationSuccess,
        submitting,
        resendEmail,
        existingUser
      ];
}
