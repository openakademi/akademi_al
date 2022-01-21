import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart'
    as AkademiTextInput;
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/view/components/feed_list.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/view/scenes/comment_list.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VirtualClassroomHome extends StatefulWidget {
  final ClassroomEntity classroomEntity;
  final EnrollmentEntity enrollmentEntity;

  const VirtualClassroomHome(
      {Key key, this.classroomEntity, this.enrollmentEntity})
      : super(key: key);

  @override
  _VirtualClassroomHomeState createState() =>
      _VirtualClassroomHomeState(classroomEntity);
}

class _VirtualClassroomHomeState extends State<VirtualClassroomHome> {
  final ClassroomEntity classroomEntity;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController _scrollController;
  int pageIndex = 0;

  _VirtualClassroomHomeState(this.classroomEntity);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return SmartRefresher(
      enablePullDown: true,
      header: MaterialClassicHeader(
        color: AntColors.blue6,
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            _getHeader(s),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<VirtualClassroomHomeBloc,
                          VirtualClassroomHomeState>(
                      buildWhen: (previous, next) =>
                          previous.comment != next.comment,
                      builder: (context, state) {
                        return state.loading == null || state.loading
                            ? Container()
                            : _getCommentInput(s, state);
                      }),
                  SizedBox(
                    height: 24.h,
                  ),
                  Expanded(
                    child: BlocBuilder<VirtualClassroomHomeBloc,
                        VirtualClassroomHomeState>(builder: (context, state) {
                      return state.loading == null || state.loading
                          ? Center(
                              child: SkeletonList(),
                            )
                          : state.feedItems != null &&
                                  state.feedItems.length != 0
                              ? FeedList(
                                  feedItems: state.feedItems,
                                  scrollController: _scrollController,
                                  userId: state.userId,
                                  itemDelete: (String itemId) {
                                    context
                                        .read<VirtualClassroomHomeBloc>()
                                        .add(DeleteFeedItem(itemId));
                                  },
                                  itemUpdate: (FeedItem item) {
                                    context
                                        .read<VirtualClassroomHomeBloc>()
                                        .add(EditComment(item));
                                  },
                                  onItemClick: (comments, feedItem) {
                                    Navigator.of(context)
                                        .push(CommentList.route(
                                            comments,
                                            feedItem,
                                            (item) {
                                              context
                                                  .read<
                                                      VirtualClassroomHomeBloc>()
                                                  .add(AddFeedComment(item));
                                            },
                                            state.userId,
                                            (String itemId) {
                                              context
                                                  .read<
                                                      VirtualClassroomHomeBloc>()
                                                  .add(DeleteFeedItem(itemId));
                                            }));
                                  },
                                )
                              : Card(
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.0.w, right: 13.w, top: 16.h),
                                      child: Column(
                                        children: [
                                          BaseText(
                                            text: s
                                                .communicate_and_get_latest_news,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                RemixIcons.todo_line,
                                                color: AntColors.gray7,
                                                size: 18.sp,
                                              ),
                                              SizedBox(
                                                width: 9.w,
                                              ),
                                              BaseText(
                                                type: TextTypes.d1,
                                                text: s.see_when_new_homework,
                                                textColor: AntColors.gray7,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _getHeader(S s) {
    return BlocBuilder<VirtualClassroomBloc, VirtualClassroomState>(
        builder: (context, state) {
      return Container(
        height: 185.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    "assets/images/classrooms_small/classrooms_small.png")),
            color: AntColors.blue6),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0.w, bottom: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 16.h,
              ),
              BaseText(
                textColor: AntColors.blue1,
                type: TextTypes.h5,
                text: state.classroomEntity.name,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.h,
              ),
              BaseText(
                textColor: AntColors.blue1,
                type: TextTypes.d1,
                text:
                    "${state.classroomEntity.userCreatedBy.firstName} ${state.classroomEntity.userCreatedBy.lastName}",
              ),
              SizedBox(
                height: 4.h,
              ),
              BaseText(
                textColor: AntColors.blue1,
                type: TextTypes.d1,
                text: s.nr_of_pupils(state.pupils?.length),
              ),
              Flexible(child: Container()),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BaseText(
                          textColor: AntColors.blue1,
                          type: TextTypes.p2,
                          text: state.classroomEntity.code,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(new ClipboardData(
                                text: state.classroomEntity.code));
                            Flushbar(
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              messageText: BaseText(
                                type: TextTypes.d1,
                                weightType: FontWeight.w600,
                                text: s.classroom_code_copied,
                                textColor: Colors.white,
                              ),
                              backgroundColor: AntColors.green6,
                              duration: Duration(seconds: 5),
                            )..show(context);
                          },
                          child: Icon(
                            RemixIcons.file_copy_line,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        )
                      ],
                    ),
                    BaseText(
                      textColor: AntColors.blue1,
                      type: TextTypes.d1,
                      text: s.classroom_code,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _getCommentInput(S s, VirtualClassroomHomeState state) {
    return AkademiTextInput.TextInput(
      hintText: s.share_smth,
      text: state.updateFeedItem != null ? state.updateFeedItem.message : null,
      hintStyle: defaultTextStyles[TextTypes.d1]
          .copyWith(color: AntColors.gray6, fontSize: 14.sp),
      suffixIcon: IconButton(
        splashRadius: 16.sp,
        onPressed: state.comment == null || state.comment.isEmpty
            ? null
            : () {
                print("heree ${state.updateFeedItem}");

                if (state.updateFeedItem != null) {
                  context
                      .read<VirtualClassroomHomeBloc>()
                      .add(SaveEditComment());
                } else {
                  print("heree");
                  FeedItem feedItem = FeedItem(
                    message: state.comment,
                    createdAt: DateTime.now().toString(),
                  );
                  context
                      .read<VirtualClassroomHomeBloc>()
                      .add(AddFeedComment(feedItem));
                }
              },
        icon: Icon(
          RemixIcons.send_plane_2_line,
          color: state.comment == null || state.comment.isEmpty
              ? AntColors.gray7
              : AntColors.blue6,
          size: 18.sp,
        ),
      ),
      onChanged: (value) {
        context.read<VirtualClassroomHomeBloc>().add(ChangedComment(value));
      },
    );
  }

  void _onRefresh() async {
    context
        .read<VirtualClassroomHomeBloc>()
        .add(LoadVirtualClassroom(classroomEntity, widget.enrollmentEntity, 0));

    _refreshController.refreshCompleted();
    pageIndex = 0;
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_scrollController.position.extentAfter == 0 &&
          context.read<VirtualClassroomHomeBloc>().state.hasMoreItems) {
        //Call the api for more data
        pageIndex += 10;
        context
            .read<VirtualClassroomHomeBloc>()
            .add(LoadNextItems(classroomEntity, pageIndex));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    context
        .read<VirtualClassroomHomeBloc>()
        .add(LoadVirtualClassroom(classroomEntity, widget.enrollmentEntity, 0));
  }
}
