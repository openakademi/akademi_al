import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/downloaded_view/bloc/download_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'offline_item_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DownloadView extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (context) {
              return DownloadViewBloc(
                  lessonRepository: LessonRepository(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),),
                authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(
                    context),);
            },
            child: DownloadView()));
  }

  @override
  _DownloadViewState createState() => _DownloadViewState();
}

class _DownloadViewState extends State<DownloadView> {
  final SlidableController _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return BlocBuilder<DownloadViewBloc, DownloadViewState>(
        buildWhen: (p, c) => p.lessons != c.lessons,
        builder: (context, state) {
          if (state.loading != null && state.loading) {
            return SkeletonList();
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Container(
                child: state.lessons != null && state.lessons.length == 0
                    ? Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/empty_downloaded/empty_downloaded.png",
                                fit: BoxFit.cover,
                                width: 94.w,
                                height: 120.h,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              BaseText(
                                text: s.no_videos_downloaded,
                                align: TextAlign.center,
                                type: TextTypes.d1,
                              )
                            ]),
                      )
                    : ListView.separated(
                        itemCount:
                            state.lessons != null ? state.lessons.length : 0,
                        itemBuilder: (context, index) {
                          final lesson = state.lessons[index];
                          return Slidable(
                            key: Key(lesson.name),
                            controller: _slidableController,
                            actionExtentRatio: 0.25,
                            actionPane: SlidableScrollActionPane(),
                            child: ListTile(
                              contentPadding: EdgeInsets.only(right: 10.w),
                              leading: TypeItem(
                                itemType: lesson.lessonType,
                              ),
                              title: BaseText(
                                text: lesson.classroomName,
                                type: TextTypes.h6,
                                textColor: AntColors.gray8,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: BaseText(
                                            text: lesson.name,
                                            type: TextTypes.d1,
                                            overflow: TextOverflow.ellipsis,
                                            weightType: FontWeight.w400,
                                            textColor: AntColors.gray8,
                                          ),
                                        ),
                                        VerticalDivider(
                                          indent: 2,
                                          endIndent: 2,
                                          color: AntColors.gray8,
                                        ),
                                        BaseText(
                                          text: lesson.fileSize,
                                          type: TextTypes.d1,
                                          weightType: FontWeight.w400,
                                          textColor: AntColors.gray6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Divider(
                                    height: 1,
                                  )
                                ],
                              ),
                              trailing: Icon(
                                RemixIcons.arrow_right_s_line,
                                size: 24.sp,
                                color: AntColors.gray7,
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(OfflineItemView.route(lesson, () {}, () {}, () {}));
                              },
                            ),
                            secondaryActions: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Container(
                                  height: 50.h,
                                  child: SlideAction(
                                    child: BaseText(
                                      text: s.delete_comment,
                                      weightType: FontWeight.w400,
                                      fontSize: 14,
                                      textColor: AntColors.gray1,
                                    ),
                                    color: AntColors.red6,
                                    onTap: () => {
                                      context
                                          .read<DownloadViewBloc>()
                                          .add(DeleteLesson(lesson)),
                                      context
                                          .read<DownloadViewBloc>()
                                          .add(LoadOfflineLessons())
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      ),
              ),
            );
          }
        });
  }

  @override
  void initState() {
    context.read<DownloadViewBloc>().add(LoadOfflineLessons());
    super.initState();
  }
}

class TypeItem extends StatelessWidget {
  final mapTypeWithIcon = {
    "VIDEO": RemixIcons.play_fill,
    "QUIZ": RemixIcons.question_fill,
    "MEETING": RemixIcons.live_fill,
    "ASSIGNMENT": RemixIcons.todo_fill,
    "PDF": RemixIcons.slideshow_2_line,
    "ENROLLMENT_STATUS_CHANGE": RemixIcons.door_open_line
  };

  final mapTypeWithBackgroundColors = {
    "VIDEO": AntColors.red1,
    "QUIZ": AntColors.gold1,
    "MEETING": AntColors.blue1,
    "ASSIGNMENT": AntColors.purple1,
    "PDF": AntColors.cyan1,
    "ENROLLMENT_STATUS_CHANGE": AntColors.blue1
  };

  final mapTypeWithColor = {
    "VIDEO": AntColors.red6,
    "QUIZ": AntColors.gold6,
    "MEETING": AntColors.blue6,
    "ASSIGNMENT": AntColors.purple6,
    "PDF": AntColors.cyan6,
    "ENROLLMENT_STATUS_CHANGE": AntColors.blue6
  };

  final String itemType;
  final double size;

  TypeItem({Key key, this.itemType, this.size = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.w,
      backgroundColor: mapTypeWithBackgroundColors[itemType],
      child: Center(
        child: Icon(
          mapTypeWithIcon[itemType],
          color: mapTypeWithColor[itemType],
        ),
      ),
    );
  }
}

