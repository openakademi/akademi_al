import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {

  @HiveField(1)
  String email;
  @HiveField(2)
  String parentEmail;
  @HiveField(3)
  String username;
  @HiveField(4)
  String dateOfBirth;
  @HiveField(5)
  String firstName;
  @HiveField(6)
  String lastName;
  @HiveField(7)
  String nationality;
  @HiveField(8)
  String status;

  User(
      {
      this.email,
      this.parentEmail,
      this.username,
      this.dateOfBirth,
      this.firstName,
      this.lastName,
      this.nationality,
      this.status,});

  factory User.fromMap(Map<String, dynamic> map) {
    return new User(
      email: map['email'] as String,
      parentEmail: map['parentEmail'] as String,
      username: map['username'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      nationality: map['nationality'] as String,
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': this.email,
      'parentEmail': this.parentEmail,
      'username': this.username,
      'dateOfBirth': this.dateOfBirth,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'nationality': this.nationality,
      'status': this.status,
    } as Map<String, dynamic>;
  }

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    parentEmail = json['parentEmail'];
    username = json['username'];
    dateOfBirth = json['dateOfBirth'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    nationality = json['nationality'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['parentEmail'] = this.parentEmail;
    data['username'] = this.username;
    data['dateOfBirth'] = this.dateOfBirth;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['nationality'] = this.nationality;
    data['status'] = this.status;
    return data;
  }

  @override
  List<Object> get props => [
        email,
        parentEmail,
        username,
        dateOfBirth,
        firstName,
        lastName,
        nationality,
        status,
      ];

  @override
  String toString() {
    return 'User{email: $email, parentEmail: $parentEmail, username: $username, dateOfBirth: $dateOfBirth, firstName: $firstName, lastName: $lastName, nationality: $nationality, status: $status}';
  }
}
