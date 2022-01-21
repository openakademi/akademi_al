part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({this.nationality = const Nationality.pure(),
    this.secondPageStatus = FormzStatus.pure,
    this.currentIndex = 0,
    this.loading = true,
    this.wizard,
    this.profilePicture = const ProfilePicture.pure(),
    this.thirdPageStatus = FormzStatus.pure,
    this.fourthPageStatus = FormzStatus.pure,
    this.fifthPageStatus = FormzStatus.pure,
    this.classes,
    this.educationLevel = const EducationLevel.pure(),
    this.gradeLevel = const GradeLevel.pure(),
    this.gradeClassId = const GradeClassId.pure(),
    this.subjects,
    this.allSubjects = false,
    this.classrooms,
    this.virtualClassCode,
    this.finished = false,
    this.errorVirtualClassCode,
    this.profilePictureType = "static"
  });

  final int currentIndex;
  final Nationality nationality;
  final FormzStatus secondPageStatus;
  final bool loading;
  final Wizard wizard;
  final ProfilePicture profilePicture;
  final String profilePictureType;
  final FormzStatus thirdPageStatus;
  final List<GradeClass> classes;
  final GradeLevel gradeLevel;
  final GradeClassId gradeClassId;
  final EducationLevel educationLevel;
  final FormzStatus fourthPageStatus;
  final FormzStatus fifthPageStatus;
  final List<Subject> subjects;
  final bool allSubjects;
  final List<String> classrooms;
  final String virtualClassCode;
  final bool finished;
  final String errorVirtualClassCode;

  @override
  List<Object> get props =>
      [
        currentIndex,
        nationality,
        secondPageStatus,
        loading,
        wizard,
        profilePicture,
        thirdPageStatus,
        fourthPageStatus,
        fifthPageStatus,
        classes,
        educationLevel,
        gradeLevel,
        gradeClassId,
        subjects,
        allSubjects,
        classrooms,
        virtualClassCode,
        finished,
        errorVirtualClassCode,
        profilePictureType,
      ];

  getPageStatus(int index) {
    switch (index) {
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
      case 4:
        {
          return fifthPageStatus;
        }
      case 5:
        {
          return classrooms != null && classrooms.isNotEmpty
              ? FormzStatus.valid
              : FormzStatus.invalid;
        }
      case 5:
        {
          return virtualClassCode.isNotEmpty;
        }
      default:
        {
          return FormzStatus.valid;
        }
    }
  }

  OnboardingState copyWith({int currentIndex,
    Nationality nationality,
    FormzStatus secondPageStatus,
    bool loading,
    Wizard wizard,
    ProfilePicture profilePicture,
    FormzStatus thirdPageStatus,
    List<GradeClass> classes,
    EducationLevel educationLevel,
    GradeLevel gradeLevel,
    GradeClassId gradeClassId,
    FormzStatus fourthPageStatus,
    FormzStatus fifthPageStatus,
    List<Subject> subjects,
    bool allSubjects,
    List<String> classrooms,
    String virtualClassCode,
    bool finished,
    String errorVirtualClassCode,
    String profilePictureType
  }) {
    return OnboardingState(
        nationality: nationality ?? this.nationality,
        currentIndex: currentIndex ?? this.currentIndex,
        secondPageStatus: secondPageStatus ?? this.secondPageStatus,
        loading: loading ?? this.loading,
        wizard: wizard ?? this.wizard,
        profilePicture: profilePicture ?? this.profilePicture,
        thirdPageStatus: thirdPageStatus ?? this.thirdPageStatus,
        classes: classes ?? this.classes,
        educationLevel: educationLevel ?? this.educationLevel,
        gradeLevel: gradeLevel ?? this.gradeLevel,
        gradeClassId: gradeClassId ?? this.gradeClassId,
        fourthPageStatus: fourthPageStatus ?? this.fourthPageStatus,
        fifthPageStatus: fifthPageStatus ?? this.fifthPageStatus,
        subjects: subjects ?? this.subjects,
        allSubjects: allSubjects ?? this.allSubjects,
        classrooms: classrooms ?? this.classrooms,
        virtualClassCode: virtualClassCode ?? this.virtualClassCode,
        finished: finished ?? this.finished,
        errorVirtualClassCode: errorVirtualClassCode ?? this.errorVirtualClassCode,
        profilePictureType: profilePictureType ?? this.profilePictureType
    );
  }
}
