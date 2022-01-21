import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/progress_lesson_enrollments_repository/lib/progress_lesson_enrollments_repository.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/quiz_user_response_repository.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/home.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/bloc/async_classroom_item_bloc.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/lesson_header.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/lesson_tree.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/main_toggle_buttons.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'lesson_details.dart';

class AsyncClassroomItem extends StatefulWidget {
  final String classroomId;
  final String imageUrl;
  final String lessonId;

  const AsyncClassroomItem(
      {Key key, this.classroomId, this.imageUrl, this.lessonId})
      : super(key: key);

  static Route route(String classroomId, String imageUrl, String lessonId) {
    return MaterialWithModalsPageRoute<void>(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) {
              return HomeBloc(
                  enrollmentRepository:
                  RepositoryProvider.of<EnrollmentRepository>(context),
                  offline: false);
            }),
            BlocProvider(
                create: (context) {
                  return AsyncClassroomItemBloc(
                      uploaderRepository: UploaderRepository(
                          RepositoryProvider.of<AuthenticationRepository>(context)),
                      userRepository: UserRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      classroomRepository: ClassroomRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      subjectPlanTreeRepository: SubjectPlanTreeRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      enrollmentRepository:
                          RepositoryProvider.of<EnrollmentRepository>(context),
                      lessonRepository: LessonRepository(
                          authenticationRepository:
                              RepositoryProvider.of<AuthenticationRepository>(
                                  context)),
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(context),
                      progressLessonEnrollmentRepository:
                          ProgressLessonEnrollmentRepository(
                              authenticationRepository:
                                  RepositoryProvider.of<AuthenticationRepository>(context)),
                      quizUserResponseRepository: QuizUserResponseRepository(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
                  organizationRepository: OrganizationRepository());
                })
          ],
          child: AsyncClassroomItem(
          classroomId: classroomId,
          imageUrl: imageUrl,
          lessonId: lessonId,
        ),
        ));
  }

  @override
  _AsyncClassroomItemState createState() => _AsyncClassroomItemState();
}

class _AsyncClassroomItemState extends State<AsyncClassroomItem>
    with TickerProviderStateMixin {
  TabController _tabController;
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<AsyncClassroomItemBloc, AsyncClassroomItemState>(
        builder: (context, state) {
          return Scaffold(
            appBar: (!state.isPreview && state.selectedLesson != null) ? AppBar(
              leading: IconButton(
                icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
                onPressed: () =>
                {
                context.read<AsyncClassroomItemBloc>().add(CloseOpenedClassroom())
                },
              ),
              elevation: 1,
              title: InkWell(
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil<void>(
                    HomePage.route(false),
                        (route) => false,
                  );
                },
                child: Image.asset(
                  "assets/logos/akademi_logo/akademi_logo.png",
                  width: 94.sp,
                  height: 24.sp,
                  fit: BoxFit.fill,
                ),
              ),
            ) : null,
            extendBodyBehindAppBar: false,
            resizeToAvoidBottomInset: false,
            body:
            state.loading != null && state.loading ?
            SafeArea(child: SkeletonList())
                :
            Stack(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _getHeader(state, s),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.h, bottom: 10.h),
                                child: MainToggleButtons(
                                    items: state.tags != null ? state.tags : [],
                                    selectedIndex: state
                                        .classroomContentTabIndex
                                ),
                              ),
                              Expanded(
                                child: _getBody(state, s),
                              ),
                              Container(
                                constraints:
                                BoxConstraints(minHeight: 0, maxHeight: 108.h),
                                decoration: BoxDecoration(
                                    color: AntColors.blue1,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AntColors.boxShadow,
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, -2),
                                      )
                                    ]),
                                child: Center(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20.0.w),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: 0,
                                        maxHeight: 335.w,
                                      ),
                                      child: Center(
                                        child: MainButton(
                                          disabled: state.submitting != null &&
                                              state.submitting,
                                          text: _buttonLabel(state, s),
                                          size: ButtonSize.Medium,
                                          height: 52.h,
                                          onPress: () {
                                            _buttonAction(state);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  state.changingItem != null && state.changingItem
                      ? Container(
                    color: Color.fromRGBO(237, 242, 247, 0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AntColors.blue6,
                      ),
                    ),
                  )
                      : Container(),
                ]),
          );
        });
    }


  _getBody(AsyncClassroomItemState state, S s) {
    if (state.isPreview != null && state.isPreview) {
      return LessonTree();
    } else {
      return NestedScrollView(
        body: TabBarView(
          controller: _tabController,
          children: [
            LessonTree(
              primaryList: false,
            ),
            LessonDetails(lesson: state.selectedLesson)
          ],
        ),
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Container(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0.w, top: 16.h, bottom: 16.h),
                      child: BaseText(
                        text: state.classroomEntity.name,
                        type: TextTypes.h5,
                        textColor: AntColors.gray8,
                      ))),
            ),
            SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: _SliverAppBarDelegate(
                    child: PreferredSize(
                  child: _getTabBar(state, s),
                  preferredSize: Size.fromHeight(40.h),
                ))),
          ];
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 2, vsync: this);

    context
        .read<AsyncClassroomItemBloc>()
        .add(LoadClassroom(widget.classroomId, widget.lessonId));
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    imageUrl = widget.imageUrl;
  }

  _getHeader(AsyncClassroomItemState state, S s) {
    if (!state.isPreview && state.selectedLesson != null) {
      return LessonHeader(
        lesson: state.selectedLesson,
        imageUrl: widget.imageUrl,
        quizAnswers: state.quizAnswers,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 187.h,
            decoration: BoxDecoration(
              image: state.classroomEntity.fileUrl != null
                  ? DecorationImage(
                      image: NetworkImage(state.classroomEntity.fileUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
              gradient: state.classroomEntity.fileUrl != null
                  ? LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)
                  : LinearGradient(
                      colors: [AntColors.blue8, AntColors.blue6],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  alignment: Alignment.bottomCenter,
                  icon: Icon(
                    RemixIcons.arrow_left_line,
                    color: AntColors.gray1,
                    size: 24.sp,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Expanded(
                  child: BaseText(
                    text: state.classroomEntity?.name,
                    fontSize: 24.sp,
                    letterSpacing: -1,
                    weightType: FontWeight.w600,
                    textColor: AntColors.gray2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          state.classroomEntity?.description != null &&
                  state.classroomEntity?.description?.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 15.h, left: 20.w, right: 20.w, bottom: 24.h),
                  child: BaseText(
                    text: state.classroomEntity?.description,
                  ),
                )
              : Container(
                  width: 0,
                ),
        ],
      );
    }
  }

  _getTabBar(AsyncClassroomItemState state, S s) {
    if (state.isPreview != null && !state.isPreview) {
      return Container(
        color: Colors.white,
        child: TabBar(
          unselectedLabelColor: AntColors.gray7,
          labelColor: AntColors.blue6,
          labelStyle: defaultTextStyles[TextTypes.h6],
          unselectedLabelStyle: defaultTextStyles[TextTypes.p2],
          tabs: [
            new Tab(
              text: s.lessons,
            ),
            new Tab(
              text: s.details,
            ),
          ],
          controller: _tabController,
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  _buttonLabel(AsyncClassroomItemState state, S s) {
    if (state.isPreview) {
      return state.userEnrolled ? s.continue_course : s.enroll;
    } else {
      if (state.selectedLesson != null) {
        if (state.selectedLesson.lessonType == "VIDEO") {
          return s.end_lesson;
        } else if (state.selectedLesson.lessonType == "QUIZ") {
          if (state.quizAnswers != null) {
            return s.redo_quiz;
          }
          return s.start_quiz;
        }
      }
      return "asd";
    }
  }

  _buttonAction(AsyncClassroomItemState state) {
    if (state.isPreview) {
      if (!state.userEnrolled) {
        context.read<AsyncClassroomItemBloc>().add(EnrollToClassroom());
      } else {
        context.read<AsyncClassroomItemBloc>().add(ContinueClassroom());
      }
    } else {
      if (state.selectedLesson.lessonType == "VIDEO") {
        context
            .read<AsyncClassroomItemBloc>()
            .add(EndLesson(state.selectedLesson.id));
      } else if (state.selectedLesson.lessonType == "QUIZ") {
        Future.delayed(Duration.zero, () {
          Quiz quiz = Quiz();
          quiz.showFilterBottomSheet(
              context,
              state.selectedLesson,
              state.enrollmentEntity.id,
              null,
              context.read<AsyncClassroomItemBloc>());
        });
      } else {}
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
