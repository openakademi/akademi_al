import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/grades_repository/lib/grades_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/grade_class.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/profile_picture_file.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/subject.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/wizard.dart';
import 'package:akademi_al_mobile_app/packages/onboarding_repository/lib/onboarding_api_provider.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({this.apiProvider, this.authenticationRepository})
      : super(OnboardingState());

  final OnboardingApiProvider apiProvider;
  final AuthenticationRepository authenticationRepository;

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is NextPage) {
      yield* _mapNextPageToState(event, state);
    } else if (event is PreviousPage) {
      yield _mapPreviousPageToState(event, state);
    } else if (event is NationalityChanged) {
      yield _mapNationalityChangedToState(event, state);
    } else if (event is LoadOnboarding) {
      yield* _mapLoadOnBoardingToState(event, state);
    } else if (event is ProfilePictureChanged) {
      yield _mapProfilePictureChanged(event, state);
    } else if (event is LoadGrades) {
      yield* _mapLoadGradesToState(event, state);
    } else if (event is EducationLevelChanged) {
      yield _mapEducationLevelChanged(event, state);
    } else if (event is GradeLevelChanged) {
      yield _mapGradeLevelChanged(event, state);
    } else if (event is GradeClassChanged) {
      yield _mapGradeClassChanged(event, state);
    } else if (event is LoadGradeSubjects) {
      yield* _mapLoadGradeSubjectsToState(event, state);
    } else if (event is CheckAllSubjects) {
      yield _mapCheckAllSubjectsToState(event, state);
    } else if (event is CheckSubjects) {
      yield _mapCheckSubjectToState(event, state);
    } else if (event is VirtualClassCodeChanged) {
      yield _mapVirtualClassCodeChangedToState(event, state);
    } else if (event is FinishOnboarding) {
      yield* _mapFinishOnboardingToState(event, state);
    } else if (event is ProfilePictureUploaded) {
      yield _mapProfilePictureUploadedToState(event, state);
    }
  }

  Stream<OnboardingState> _mapNextPageToState(
      NextPage event, OnboardingState state) async* {
    final newWizard = _mapStateToWizard(state);
    await apiProvider.updateWizard(newWizard);
    final newIndex = state.currentIndex + 1;
    yield state.copyWith(currentIndex: newIndex, wizard: newWizard);
  }

  OnboardingState _mapPreviousPageToState(
      PreviousPage event, OnboardingState state) {
    final newIndex = state.currentIndex - 1;
    return state.copyWith(currentIndex: newIndex > 0 ? newIndex : 0);
  }

  OnboardingState _mapNationalityChangedToState(
      NationalityChanged event, OnboardingState state) {
    final nationality = Nationality.dirty(event.nationality);
    return state.copyWith(
        nationality: nationality,
        secondPageStatus: Formz.validate([nationality]));
  }

  Stream<OnboardingState> _mapLoadOnBoardingToState(
      LoadOnboarding event, OnboardingState state) async* {
    try {
      final wizard = await apiProvider.getWizard();
      wizard.state.navigationItems
          .sort((first, second) => (first.priority).compareTo(second.priority));
      final currentIndex = wizard.state.navigationItems
          .firstWhere((element) =>
              element.status.index == NavigationItemStatus.Active.index)
          .priority;
      var nationality = Nationality.pure();
      if (wizard.state.nationality != null) {
        nationality = Nationality.dirty(wizard.state.nationality);
      }
      var profilePicture = ProfilePicture.pure();
      if (wizard.state.profilePicture != null) {
        profilePicture = ProfilePicture.dirty(wizard.state.profilePicture);
      }

      var level = GradeLevel.pure();

      if (wizard.state.level != null) {
        level = GradeLevel.dirty(wizard.state.level);
      }

      var gradeClass = GradeClassId.pure();
      if (wizard.state.grade != null) {
        gradeClass = GradeClassId.dirty(wizard.state.grade);
      }

      var classrooms;
      if (wizard.state.classRooms != null) {
        classrooms = List<String>.from(wizard.state.classRooms);
      }
      var profilePictureType = "static";
      if (wizard.state.profilePictureType != null) {
        profilePictureType = wizard.state.profilePictureType;
      }

      yield state.copyWith(
          currentIndex: currentIndex,
          wizard: wizard,
          loading: false,
          nationality: nationality,
          secondPageStatus: Formz.validate([nationality]),
          profilePicture: profilePicture,
          thirdPageStatus: Formz.validate([profilePicture]),
          gradeLevel: level,
          gradeClassId: gradeClass,
          fourthPageStatus: Formz.validate([level, gradeClass]),
          classrooms: classrooms,
          profilePictureType: profilePictureType);
    } catch (e) {
      final userRole = await authenticationRepository.getCurrentUserRole();
      final wizard = await apiProvider.createWizard(userRole);
      yield state.copyWith(wizard: wizard, loading: false);
    }
  }

  OnboardingState _mapProfilePictureChanged(
      ProfilePictureChanged event, OnboardingState state) {
    final profilePicture = ProfilePicture.dirty(event.profilePicture);
    return state.copyWith(
        profilePictureType: "static",
        profilePicture: profilePicture,
        thirdPageStatus: Formz.validate([profilePicture]));
  }

  Stream<OnboardingState> _mapLoadGradesToState(
      LoadGrades event, OnboardingState state) async* {
    if (state.classes == null) {
      final gradesApiProvider = GradesApiProvider(
        authenticationRepository
      );
      final gradesJson = await gradesApiProvider.getAllGrades();

      List<GradeClass> classes = List.from(gradesJson)
          .map((model) => GradeClass.fromJson(model))
          .toList();
      yield state.copyWith(classes: classes);
    }
  }

  OnboardingState _mapEducationLevelChanged(
      EducationLevelChanged event, OnboardingState state) {
    final educationLevel = EducationLevel.dirty(event.educationLevel);
    return state.copyWith(
        educationLevel: educationLevel,
        fourthPageStatus: Formz.validate([educationLevel]));
  }

  OnboardingState _mapGradeLevelChanged(
      GradeLevelChanged event, OnboardingState state) {
    final gradeLevel = GradeLevel.dirty(event.gradeLevel);
    final gradeClassId = GradeClassId.pure();
    return state.copyWith(
        gradeLevel: gradeLevel,
        gradeClassId: gradeClassId,
        allSubjects: false,
        fifthPageStatus: Formz.validate([gradeLevel, gradeClassId]));
  }

  OnboardingState _mapGradeClassChanged(
      GradeClassChanged event, OnboardingState state) {
    final gradeClass = GradeClassId.dirty(event.gradeClassId);
    return state.copyWith(
        gradeClassId: gradeClass,
        fifthPageStatus: Formz.validate([state.gradeLevel, gradeClass]));
  }

  Stream<OnboardingState> _mapLoadGradeSubjectsToState(
      LoadGradeSubjects event, OnboardingState state) async* {
    final subjectsJson =
        await apiProvider.getSubjectsBasedOnGrade(state.gradeClassId.value);

    List<Subject> classes = List.from(subjectsJson)
        .map((model) => Subject.fromJson(model))
        .toList();

    yield state.copyWith(subjects: classes);
  }

  OnboardingState _mapCheckAllSubjectsToState(
      CheckAllSubjects event, OnboardingState state) {
    if (state.allSubjects != null && state.allSubjects) {
      return state.copyWith(
          allSubjects: false, classrooms: List.empty(growable: true));
    } else {
      final classrooms = state.subjects.map((e) => e.classRoomId).toList();

      return state.copyWith(allSubjects: true, classrooms: classrooms);
    }
  }

  OnboardingState _mapCheckSubjectToState(
      CheckSubjects event, OnboardingState state) {
    final classrooms = state.classrooms != null
        ? state.classrooms
        : List<String>.empty(growable: true);
    if (classrooms.contains(event.classroomId)) {
      final newList = List<String>.from(classrooms);
      newList.remove(event.classroomId);
      return state.copyWith(classrooms: newList);
    } else {
      final newList = List<String>.from(classrooms);
      newList.add(event.classroomId);
      return state.copyWith(classrooms: newList);
    }
  }

  Wizard _mapStateToWizard(OnboardingState state) {
    final wizard = state.wizard;
    final currentNavigationItems =
        List<NavigationItems>.from(wizard.state.navigationItems);
    final currentPage = currentNavigationItems[state.currentIndex];

    if (state.currentIndex < 6) {
      final nextPage = currentNavigationItems[state.currentIndex + 1];
      currentNavigationItems[state.currentIndex + 1] =
          nextPage.copyWith(status: NavigationItemStatus.Active);
    }
    currentNavigationItems[state.currentIndex] = currentPage.copyWith(
        status: state.getPageStatus(state.currentIndex) == FormzStatus.valid
            ? NavigationItemStatus.Complete
            : NavigationItemStatus.Active);
    final newState = wizard.state.copyWith(
        nationality: state.nationality.value,
        profilePictureType: state.profilePictureType,
        profilePicture: state.profilePicture.value,
        level: state.gradeLevel.value,
        grade: state.gradeClassId.value,
        education: state.educationLevel.value,
        classRooms: state.classrooms,
        virtualClassCode: state.virtualClassCode,
        navigationItems: currentNavigationItems);

    return state.wizard.copyWith(state: newState);
  }

  OnboardingState _mapVirtualClassCodeChangedToState(
      VirtualClassCodeChanged event, OnboardingState state) {
    return state.copyWith(virtualClassCode: event.code);
  }

  Stream<OnboardingState> _mapFinishOnboardingToState(
      FinishOnboarding event, OnboardingState state) async* {
    try {
      final finalWizard = _mapStateToWizard(state);
      if(state.currentIndex == 3 && state.educationLevel.value != 'PRE_SCHOOL'){
        await apiProvider.updateWizard(finalWizard);
      }
      await apiProvider.finish(finalWizard);
      //TODO rereoute
      await authenticationRepository.refreshToken(null);
      yield state.copyWith(finished: true);
    } catch (e) {
      print("$e");
      if (e is ConnectionException) {}
      yield state.copyWith(
          errorVirtualClassCode: "Ky kod eshtë i pavlefshëm. Provoni përsëri");
    }
  }

  _mapProfilePictureUploadedToState(
      ProfilePictureUploaded event, OnboardingState state) {
    final profilePicture = ProfilePicture.dirty(event.file.id);
    final wizard = state.wizard;
    final newState = wizard.state.copyWith(profilePictureFile: event.file);
    final newWizard = wizard.copyWith(state: newState);
    return state.copyWith(
        profilePicture: profilePicture,
        profilePictureType: "upload",
        wizard: newWizard,
        thirdPageStatus: FormzStatus.valid);
  }
}
