import 'dart:async';

import 'package:akademi_al_mobile_app/components/button/lib/button_utils.dart';
import 'package:akademi_al_mobile_app/components/button/lib/main_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/analytics_course_progress/lib/analytics_course_progress_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/feed_repository/feed_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_settings_repository/lib/user_settings_api_provider.dart';
import 'package:akademi_al_mobile_app/src/calendar/bloc/calendar_bloc.dart';
import 'package:akademi_al_mobile_app/src/calendar/view/calendar_view.dart';
import 'package:akademi_al_mobile_app/src/classrooms/bloc/classrooms_bloc.dart';
import 'package:akademi_al_mobile_app/src/classrooms/view/classrooms_scene.dart';
import 'package:akademi_al_mobile_app/src/dashboard/bloc/dashboard_bloc.dart';
import 'package:akademi_al_mobile_app/src/dashboard/view/dashboard_scene.dart';
import 'package:akademi_al_mobile_app/src/downloaded_view/bloc/download_view_bloc.dart';
import 'package:akademi_al_mobile_app/src/downloaded_view/view/download_view.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/home/view/scenes/home_scene.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/bloc/async_subject_bloc.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/view/subjects_scene.dart';
import 'package:akademi_al_mobile_app/src/synchronization/bloc/synchronization_bloc.dart';
import 'package:akademi_al_mobile_app/src/user_config/view/main_user_avatar.dart';
import 'package:akademi_al_mobile_app/src/user_profile/bloc/user_profile_bloc.dart';
import 'package:akademi_al_mobile_app/src/user_profile/view/user_profile.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/virtual_classroom.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/virtual_classroom_provider.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/virtual_classroom_utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/custom_app_bar.dart';
import 'components/navigation_item.dart';
import 'components/virtual_class_navigation_item.dart';

class HomePage extends StatefulWidget {
  static Route route(bool offline) {
    return MaterialWithModalsPageRoute<void>(
        builder: (_) => MultiBlocProvider(providers: [
              BlocProvider(create: (context) {
                return HomeBloc(
                    enrollmentRepository:
                        RepositoryProvider.of<EnrollmentRepository>(context),
                    offline: offline);
              }),
              BlocProvider(
                create: (context) {
                  return AsyncSubjectBloc(AsyncSubjectRepository(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context)));
                },
              ),
              BlocProvider(
                create: (context) {
                  return ClassroomsBloc(
                      enrollmentRepository: EnrollmentRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      uploaderRepository: UploaderRepository(
                          RepositoryProvider.of<AuthenticationRepository>(
                              context)));
                },
              ),
              BlocProvider(
                create: (context) {
                  return SynchronizationBloc(
                      enrollmentRepository:
                          RepositoryProvider.of<EnrollmentRepository>(context),
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context));
                },
              ),
              BlocProvider(
                create: (context) {
                  return VirtualClassroomHomeBloc(
                      classroomRepository: ClassroomRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      ),
                      userRepository: UserRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      enrollmentRepository:
                          RepositoryProvider.of<EnrollmentRepository>(context),
                      feedRepository: FeedRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)));
                },
              ),
              BlocProvider(
                create: (context) {
                  return VirtualClassroomContentBloc(
                      subjectPlanTreeRepository: SubjectPlanTreeRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      ),
                      enrollmentRepository:
                          RepositoryProvider.of<EnrollmentRepository>(context),
                  organizationRepository: OrganizationRepository());
                },
              ),
              BlocProvider(
                create: (context) {
                  return VirtualClassroomHomeworkBloc(
                      subjectPlanTreeRepository: SubjectPlanTreeRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      ),
                      userCommitsRepository: UserCommitsRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      ));
                },
              ),
              BlocProvider(
                create: (context) {
                  return DashboardBloc(
                      classroomRepository: ClassroomRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      ),
                      enrollmentRepository:
                          RepositoryProvider.of<EnrollmentRepository>(context),
                      asyncSubjectRepository: AsyncSubjectRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      userCommitsRepository: UserCommitsRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context),
                      ));
                },
              ),
              BlocProvider(
                create: (context) {
                  return UserProfileBloc(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context),
                      userSettingsApiProvider: UserSettingsApiProvider(
                          RepositoryProvider.of<AuthenticationRepository>(
                              context)),
                      analyticsCourseProgressApiProvider:
                          AnalyticsCourseProgressApiProvider(
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      uploaderRepository: UploaderRepository(
                          RepositoryProvider.of<AuthenticationRepository>(
                              context)));
                },
              ),
              BlocProvider(
                create: (context) {
                  return DownloadViewBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                    lessonRepository: LessonRepository(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context),
                    ),
                  );
                },
              )
            ], child: HomePage()));
  }

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<SubjectsSceneState> subjectKey;
  GlobalKey<MainUserAvatarState> avatarKey;
  GlobalKey<CustomAppBarState> appBarState;
  GlobalKey<VirtualClassroomSceneState> openedClassroomKey;

  ConnectivityResult _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<Widget> actions;
  bool firstConnection = true;

  PackageInfo _packageInfo;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    final s = S.of(context);
    if (result == ConnectivityResult.none) {
      firstConnection = false;
      context
          .read<HomeBloc>()
          .add(NavigationItemChanged(NavigationItemKey.DOWNLOADED, "", null));
    } else {
      if (!firstConnection) {
        firstConnection = false;
        Flushbar(
          icon: Icon(
            RemixIcons.checkbox_circle_fill,
            color: AntColors.green6,
            size: 16.sp,
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          messageText: BaseText(
            type: TextTypes.d1,
            text: s.activeConnection,
            textColor: AntColors.gray9,
            //fontSize: 14.sp,
          ),
          backgroundColor: AntColors.green1,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    }
    setState(() => _connectionStatus = result);
  }

  @override
  void initState() {
    super.initState();
    subjectKey = GlobalKey();
    avatarKey = GlobalKey();
    appBarState = GlobalKey();
    // actions = _getActions(NavigationItemKey.HOME);
    context.read<HomeBloc>().add(DrawerOpenedFirstTime());
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<HomeBloc, HomeState>(buildWhen: (previus, next) {
      if (previus.currentNavigationItem.index !=
              next.currentNavigationItem.index ||
          previus.selectedVirtualClassroomId !=
              next.selectedVirtualClassroomId) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        floatingActionButton:
            state.currentNavigationItem.index == NavigationItemKey.HOME.index ||
                    state.currentNavigationItem.index ==
                        NavigationItemKey.CLASSROOMS.index
                ? FloatingActionButton(
                    backgroundColor: AntColors.blue6,
                    child: Icon(Icons.add),
                    onPressed: () {
                      VirtualClassroomUtils virtualClassroom =
                          VirtualClassroomUtils();
                      virtualClassroom.showFilterBottomSheet(context);
                    },
                  )
                : null,
        appBar: CustomAppBar(
          key: appBarState,
          subjectKey: subjectKey,
          avatarKey: avatarKey,
          virtualClassroomKey: openedClassroomKey,
          offline: _connectionStatus == ConnectivityResult.none,
        ),
        drawer: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, next) {
            return previous.currentNavigationItem.index !=
                    next.currentNavigationItem.index ||
                previous.selectedVirtualClassroomId !=
                    next.selectedVirtualClassroomId;
          },
          listener: (context, state) {
            Navigator.pop(context);
          },
          child: Drawer(
              child: SingleChildScrollView(
            child: _getDrawerChildren(s, state),
          )),
        ),
        body: _getPage(state),
        bottomSheet: _connectionStatus != null &&
                _connectionStatus == ConnectivityResult.none
            ? Container(
                height: 38,
                color: AntColors.blue1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 14.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      Icon(RemixIcons.information_line,
                          size: 16.sp, color: AntColors.gray8),
                      SizedBox(
                        width: 8.w,
                      ),
                      BaseText(
                        text: s.internet_missing,
                        type: TextTypes.d1,
                        textColor: AntColors.gray9,
                      ),
                    ],
                  ),
                ),
              )
            : null,
      );
    });
  }

  _getDrawerChildren(S s, HomeState state) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: (50.w), left: 16.w, right: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Image.asset(
                          "assets/logos/akademi_logo/akademi_logo.png",
                          width: 94.sp,
                          height: 24.sp,
                          fit: BoxFit.fill,
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.zero,
                        icon: Icon(RemixIcons.close_line),
                        iconSize: 24.sp,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0.h),
                  child: Divider(
                    thickness: 1,
                    color: AntColors.gray5,
                  ),
                ),
                NavigationItem(
                  text: s.home,
                  remixIcon: RemixIcons.home_3_line,
                  navigationKey: NavigationItemKey.HOME,
                ),
                NavigationItem(
                    text: s.classrooms,
                    remixIcon: RemixIcons.function_line,
                    navigationKey: NavigationItemKey.CLASSROOMS),
                NavigationItem(
                    text: s.calendar,
                    remixIcon: RemixIcons.calendar_2_line,
                    navigationKey: NavigationItemKey.CALENDAR),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: Divider(
                    thickness: 1,
                    color: AntColors.gray4,
                  ),
                ),
                NavigationItem(
                    text: s.subjects,
                    remixIcon: RemixIcons.list_check,
                    navigationKey: NavigationItemKey.SUBJECTS),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: Divider(
                    thickness: 1,
                    color: AntColors.gray4,
                  ),
                ),
                NavigationItem(
                    text: s.downloaded,
                    remixIcon: RemixIcons.download_line,
                    navigationKey: NavigationItemKey.DOWNLOADED),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: Divider(
                    thickness: 1,
                    color: AntColors.gray4,
                  ),
                ),
                VirtualClassNavigator(s: s),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: MainButton(
                    size: ButtonSize.Small,
                    height: 44.h,
                    prefixIcon: Icon(
                      RemixIcons.add_line,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                    onPress: () {
                      VirtualClassroomUtils virtualClassroom =
                          VirtualClassroomUtils();
                      virtualClassroom.showFilterBottomSheet(context);
                    },
                    text: s.join_virtual_classroom,
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(builder: (builder, state) {
                  if (state.loading != null && state.loading) {
                    return Flexible(child: SkeletonList());
                  } else {
                    return Flexible(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: AntColors.gray4))),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.allVirtualClasses != null &&
                                    state.allVirtualClasses
                                ? state.virtualClassEnrollments != null
                                    ? state.virtualClassEnrollments.length
                                    : 0
                                : state.virtualClassEnrollments != null &&
                                        state.virtualClassEnrollments.length >=
                                            5
                                    ? 5
                                    : state.virtualClassEnrollments.length,
                            itemBuilder: (context, index) {
                              return NavigationItem(
                                  height: 60,
                                  text: state.virtualClassEnrollments[index]
                                      .classroom.name,
                                  remixIcon: RemixIcons.door_open_line,
                                  navigationKey:
                                      NavigationItemKey.VIRTUAL_CLASSROOM,
                                  classroomId: state
                                      .virtualClassEnrollments[index]
                                      .classroomId,
                                  enrollment:
                                      state.virtualClassEnrollments[index]);
                            },
                          ),
                        ),
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BaseText(
                          align: TextAlign.start,
                          text: s.others,
                          type: TextTypes.h6,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 52.h,
                          child: GestureDetector(
                            onTap: () async {
                              final url = s.privacy_policy_link;
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                SizedBox(
                                  width: 16.w,
                                ),
                                Icon(
                                  RemixIcons.file_line,
                                  color: AntColors.gray7,
                                  size: 18.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                BaseText(
                                  align: TextAlign.center,
                                  text: s.privacy_policy,
                                  textColor: AntColors.gray8,
                                ),
                                Expanded(child: Container()),
                                Icon(
                                  RemixIcons.arrow_right_s_line,
                                  color: AntColors.gray7,
                                  size: 24.sp,
                                ),
                                SizedBox(
                                  width: 16.w,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 52.h,
                          child: GestureDetector(
                            onTap: () async {
                              final url = s.terms_and_conditions_link;
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                SizedBox(
                                  width: 16.w,
                                ),
                                Icon(
                                  RemixIcons.book_2_line,
                                  color: AntColors.gray7,
                                  size: 18.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                BaseText(
                                  align: TextAlign.center,
                                  text: s.terms_and_conditions,
                                  textColor: AntColors.gray8,
                                ),
                                Expanded(child: Container()),
                                Icon(
                                  RemixIcons.arrow_right_s_line,
                                  color: AntColors.gray7,
                                  size: 24.sp,
                                ),
                                SizedBox(
                                  width: 16.w,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0.h, top: 8.0.h),
                  child: Divider(
                    thickness: 1,
                    color: AntColors.gray4,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                        onTap: () async {
                          final url = s.facebook_link;
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                        child: Icon(RemixIcons.facebook_box_fill,
                            size: 32.sp, color: AntColors.gray6)),
                    SizedBox(
                      width: 16.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final url = s.instagram_link;
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      child: Icon(RemixIcons.instagram_fill,
                          size: 32.sp, color: AntColors.gray6),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    _packageInfo != null
                        ? BaseText(
                            type: TextTypes.d1,
                            textColor: AntColors.gray6,
                            text: s.version(_packageInfo.version),
                          )
                        : Container(),
                    SizedBox(
                      width: 16.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getPage(HomeState state) {
    if (state.currentNavigationItem.index == NavigationItemKey.HOME.index) {
      return DashboardScene(
        allEnrollments: state.allEnrollments,
      );
    } else if (state.currentNavigationItem.index ==
        NavigationItemKey.SUBJECTS.index) {
      return AsyncSubjectScene(subjectKey: subjectKey);
    } else if (state.currentNavigationItem.index ==
        NavigationItemKey.CLASSROOMS.index) {
      return ClassroomsScene();
    } else if (state.currentNavigationItem.index ==
        NavigationItemKey.VIRTUAL_CLASSROOM.index) {
      var currentKey = openedClassroomKey != null
          ? openedClassroomKey
          : GlobalKey<VirtualClassroomSceneState>();
      if (openedClassroomKey == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          openedClassroomKey = currentKey;
          appBarState.currentState.setState(() {
            appBarState.currentState.virtualClassroomKey = openedClassroomKey;
          });
        });
      } else {
        if (openedClassroomKey.currentState?.classroomId !=
            state.selectedVirtualClassroomId) {
          currentKey = GlobalKey<VirtualClassroomSceneState>();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            openedClassroomKey = currentKey;
            appBarState.currentState.setState(() {
              appBarState.currentState.virtualClassroomKey = openedClassroomKey;
            });
          });
        }
      }

      return VirtualClassroomProvider(
        stateKey: currentKey,
        lessonId: state.lessonToOpen,
        testActions: () {
          print("here1");
        },
        classroomId: state.selectedVirtualClassroomId,
        enrollmentEntity: state.virtualClassEnrollments?.firstWhere(
            (element) =>
                element.classroomId == state.selectedVirtualClassroomId,
            orElse: () => null),
      );
    } else if (state.currentNavigationItem.index ==
        NavigationItemKey.USER_PROFILE.index) {
      return UserProfile();
    } else if (state.currentNavigationItem.index ==
        NavigationItemKey.DOWNLOADED.index) {
      return DownloadView();
    } else if (state.currentNavigationItem.index ==
        NavigationItemKey.CALENDAR.index) {
      return BlocProvider(
          create: (context) => CalendarBloc(
                  lessonRepository: LessonRepository(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              )),
          child: CalendarView());
    } else {
      return HomeScene();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
