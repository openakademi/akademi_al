import 'dart:async';

import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/onboarding_repository/lib/onboarding_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/send_email_repository/lib/send_email_api_provider.dart';
import 'package:akademi_al_mobile_app/src/authentication/block/authentication_bloc.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/parent/view/parent_scene.dart';
import 'package:akademi_al_mobile_app/src/select_organization/view/scenes/select_organization.dart';
import 'package:akademi_al_mobile_app/src/splash/splash.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'login_scenes/information/view/information_page.dart';
import 'login_scenes/onboarding/view/onboarding_page.dart';
import 'login_scenes/teacher/view/teacher_scene.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    @required this.authenticationRepository,
    @required this.enrollmentRepository,
    @required this.onboardingApiProvider,
    @required this.sendEmailApiProvider,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final EnrollmentRepository enrollmentRepository;
  final OnboardingApiProvider onboardingApiProvider;
  final SendEmailApiProvider sendEmailApiProvider;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<OnboardingApiProvider>(
          create: (context) => onboardingApiProvider,
        ),
        RepositoryProvider<EnrollmentRepository>(
            create: (context) => enrollmentRepository),
        RepositoryProvider<SendEmailApiProvider>(
            create: (context) => sendEmailApiProvider)
      ],
      child: BlocProvider(
          create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository),
          child: AppView()),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _secondNavigatorKey = GlobalKey<NavigatorState>();

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initFluttreDownloader();
  }

  _initFluttreDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      builder: (context, child) {
        ScreenUtil.init(context,
            designSize: Size(375, 814), allowFontScaling: false);
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                {
                  final userRoleCode = state.roles.lastWhere(
                      (element) => element.code == "_TEACHER",
                      orElse: () => null);
                  if (state.roles.lastWhere(
                              (element) => element.code == "_STUDENT",
                              orElse: () => null) !=
                          null &&
                      state.user.status != "NEW" &&
                      state.user.status != "ONBOARDING") {
                    Future.delayed(Duration.zero, () {
                      _navigator.pushAndRemoveUntil(
                          SelectOrganization.route(false), (route) => false);
                    });
                  } else if (state.roles.lastWhere(
                          (element) => element.code == "_TEACHER",
                          orElse: () => null) !=
                      null) {
                    Future.delayed(Duration.zero, () {
                      _navigator.pushAndRemoveUntil<void>(
                        TeacherScene.route(),
                        (route) => false,
                      );
                    });
                  } else if (state.roles.lastWhere(
                          (element) => element.code == "_PARENT",
                          orElse: () => null) !=
                      null) {
                    Future.delayed(Duration.zero, () {
                      _navigator.pushAndRemoveUntil<void>(
                        ParentScene.route(),
                        (route) => false,
                      );
                    });
                  } else {
                    Future.delayed(Duration.zero, () {
                      _navigator.pushAndRemoveUntil<void>(
                        OnboardingPage.route(state.user),
                        (route) => false,
                      );
                    });
                  }
                  break;
                }
              case AuthenticationStatus.unauthenticated:
                Future.delayed(Duration.zero, () {
                  _navigator.pushAndRemoveUntil<void>(
                    InformationPage.route(),
                    (route) => false,
                  );
                });
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
      theme: ThemeData(
          buttonColor: Color.fromARGB(255, 32, 99, 227),
          primaryColor: Colors.white,
          accentColor: Color.fromARGB(255, 32, 99, 227),
          fontFamily: "Inter"
          // primarySwatch: MaterialColor()
          ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
