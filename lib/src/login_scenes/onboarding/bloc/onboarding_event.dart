part of 'onboarding_bloc.dart';

class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class NextPage extends OnboardingEvent {

  NextPage();

  @override
  List<Object> get props => [];
}

class PreviousPage extends OnboardingEvent {

  PreviousPage();

  @override
  List<Object> get props => [];
}

class NationalityChanged extends OnboardingEvent {

  final String nationality;

  NationalityChanged({this.nationality});

  @override
  List<Object> get props => [nationality];
}

class ProfilePictureChanged extends OnboardingEvent {

  final String profilePicture;

  ProfilePictureChanged({this.profilePicture});

  @override
  List<Object> get props => [profilePicture];
}

class ProfilePictureUploaded extends OnboardingEvent {

  final ProfilePictureFile file;

  ProfilePictureUploaded({this.file});

  @override
  List<Object> get props => [file];
}

class LoadOnboarding extends OnboardingEvent {
  LoadOnboarding();

  @override
  List<Object> get props => [];
}

class LoadGrades extends OnboardingEvent {
  LoadGrades();

  @override
  List<Object> get props => [];
}

class LoadGradeSubjects extends OnboardingEvent {
  LoadGradeSubjects();

  @override
  List<Object> get props => [];
}

class EducationLevelChanged extends OnboardingEvent {

  final String educationLevel;

  EducationLevelChanged({this.educationLevel});

  @override
  List<Object> get props => [educationLevel];
}

class GradeLevelChanged extends OnboardingEvent {

  final String gradeLevel;

  GradeLevelChanged({this.gradeLevel});

  @override
  List<Object> get props => [gradeLevel];
}

class GradeClassChanged extends OnboardingEvent {

  final String gradeClassId;

  GradeClassChanged({this.gradeClassId});

  @override
  List<Object> get props => [gradeClassId];
}

class CheckAllSubjects extends OnboardingEvent {
  CheckAllSubjects();

  @override
  List<Object> get props => [];
}


class CheckSubjects extends OnboardingEvent {

  final String classroomId;

  CheckSubjects(this.classroomId);

  @override
  List<Object> get props => [classroomId];
}

class VirtualClassCodeChanged extends OnboardingEvent {
  final String code;

  VirtualClassCodeChanged(this.code);
  @override
  List<Object> get props => [code];
}

class FinishOnboarding extends OnboardingEvent {
  FinishOnboarding();

  @override
  List<Object> get props => [];
}

