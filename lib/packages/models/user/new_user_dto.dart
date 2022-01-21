class NewUserDto {
  final String id;
  final String email;
  final String parentEmail;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String password;
  final String username;
  final String roleCode;
  final String recaptchaValue;

  NewUserDto({this.id, this.email, this.parentEmail, this.firstName, this.lastName,
      this.dateOfBirth, this.password, this.username, this.roleCode, this.recaptchaValue});

  factory NewUserDto.fromMap(Map<String, dynamic> map) {
    return new NewUserDto(
      email: map['email'] as String,
      parentEmail: map['parentEmail'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      password: map['password'] as String,
      username: map['username'] as String,
      roleCode: map['roleCode'] as String,
      recaptchaValue: map['recaptchaValue'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'email': this.email,
      'parentEmail': this.parentEmail,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'dateOfBirth': this.dateOfBirth,
      'password': this.password,
      'username': this.username,
      'roleCode': this.roleCode,
      'recaptchaValue':this.recaptchaValue
    } as Map<String, dynamic>;
  }
}
