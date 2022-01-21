import 'dart:async';
import 'dart:io';

import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/authorization_token.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organizations.dart';
import 'package:akademi_al_mobile_app/packages/models/user/roles.dart';
import 'package:akademi_al_mobile_app/packages/onboarding_repository/lib/onboarding_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/send_email_repository/lib/send_email_api_provider.dart';
import 'package:akademi_al_mobile_app/src/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'packages/authentication_repository/lib/authentication_repository.dart';
import 'packages/models/async_subjects/file_entity.dart' as FileEntity;
import 'src/utils/consts.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class AppLifecycleReactor extends StatefulWidget {
  const AppLifecycleReactor(
      {Key key,
      EnrollmentRepository enrollmentRepository,
      AuthenticationRepository authenticationRepository,
      OnboardingApiProvider onboardingApiProvider,
      SendEmailApiProvider sendEmailApiProvider})
      : _authenticationRepository = authenticationRepository,
        _enrollmentRepository = enrollmentRepository,
        _onboardingApiProvider = onboardingApiProvider,
        _sendEmailApiProvider = sendEmailApiProvider,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final EnrollmentRepository _enrollmentRepository;
  final OnboardingApiProvider _onboardingApiProvider;
  final SendEmailApiProvider _sendEmailApiProvider;

  @override
  _AppLifecycleReactorState createState() => _AppLifecycleReactorState(
      authenticationRepository: _authenticationRepository,
      enrollmentRepository: _enrollmentRepository,
      onboardingApiProvider: _onboardingApiProvider,
      sendEmailApiProvider: _sendEmailApiProvider
  );
}

class _AppLifecycleReactorState extends State<AppLifecycleReactor>
    with WidgetsBindingObserver {
  _AppLifecycleReactorState(
      {AuthenticationRepository authenticationRepository,
      EnrollmentRepository enrollmentRepository,
      OnboardingApiProvider onboardingApiProvider, SendEmailApiProvider sendEmailApiProvider})
      : _authenticationRepository = authenticationRepository,
        _enrollmentRepository = enrollmentRepository,
        _onboardingApiProvider = onboardingApiProvider,
        _sendEmailApiProvider = sendEmailApiProvider
  ;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;
  final AuthenticationRepository _authenticationRepository;
  final EnrollmentRepository _enrollmentRepository;
  final OnboardingApiProvider _onboardingApiProvider;
  final SendEmailApiProvider _sendEmailApiProvider;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MyApp(
      authenticationRepository: _authenticationRepository,
      enrollmentRepository: _enrollmentRepository,
      onboardingApiProvider: _onboardingApiProvider,
        sendEmailApiProvider :_sendEmailApiProvider
    );
  }
}

void main() async {
  _enablePlatformOverrideForDesktop();
  await Hive.initFlutter();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true);
  } catch (e) {
    print("$e");
  }
  await Hive.openBox(synchronization_time_box_name);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(EnrollmentEntityAdapter());
  Hive.registerAdapter(ClassroomEntityAdapter());
  Hive.registerAdapter(FileAdapter());
  Hive.registerAdapter(SubjectPlanAdapter());
  Hive.registerAdapter(SubjectPlanTreeAdapter());
  Hive.registerAdapter(GradeSubjectAdapter());
  Hive.registerAdapter(LessonsAdapter());
  Hive.registerAdapter(EnrollmentClassroomUserCreatedByAdapter());
  Hive.registerAdapter(EnrollmentClassroomFileAdapter());
  Hive.registerAdapter(AuthorizationTokenAdapter());
  Hive.registerAdapter(RolesAdapter());
  Hive.registerAdapter(OrganizationAdapter());
  Hive.registerAdapter(UserCreatedByAdapter());
  Hive.registerAdapter(AsyncSubjectAdapter());
  Hive.registerAdapter(GradeSubjectsAdapter());
  Hive.registerAdapter(FileEntity.FileAdapter());
  Hive.registerAdapter(LessonSectionsAdapter());
  var authenticationRepository = AuthenticationRepository();
  var enrollmentRepository =
      EnrollmentRepository(authenticationRepository: authenticationRepository);
  var onboardingRepository = OnboardingApiProvider(authenticationRepository);
  var sendEmailApiProvider = SendEmailApiProvider(authenticationRepository);
  runApp(AppLifecycleReactor(
      authenticationRepository: authenticationRepository,
      enrollmentRepository: enrollmentRepository,
      onboardingApiProvider: onboardingRepository,
      sendEmailApiProvider: sendEmailApiProvider));
}
