import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/downloader/downloader.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/user_avatar/user_avatar.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FeedEntry extends StatelessWidget {
  final FeedItem feedItem;
  final List<FeedItem> comments;
  final bool isComment;
  final Function(List<FeedItem> comments, FeedItem feedItem) onItemClick;
  final String userId;
  final Function deleteEntry;
  final Function editEntry;

  const FeedEntry(
      {Key key,
      this.feedItem,
      this.comments,
      this.isComment = false,
      this.userId,
      this.onItemClick,
      this.deleteEntry,
      this.editEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return isComment
        ? _getContainer(s, context)
        : GestureDetector(
            onTap: () {
              if (feedItem.navigateUrl != null) {
                String lessonId = feedItem.navigateUrl.split("/").last;
                context
                    .read<VirtualClassroomBloc>()
                    .add(LessonChangedEvent(lessonId));
              }
            },
            child: Card(
              child: _getContainer(s, context),
            ),
          );
  }

  _getContainer(S s, context) {
    return Container(
      // height: 32.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: feedItem.type != null
                            ? TypeItem(
                                itemType: feedItem.type,
                              )
                            : UserAvatar(
                                userId: feedItem.userId,
                              )),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                        child: isComment
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getBody(),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  BaseText(
                                    type: TextTypes.d1,
                                    textColor: AntColors.gray8,
                                    text: feedItem.message,
                                  )
                                ],
                              )
                            : _getBody()),
                    feedItem.userId == userId
                        ? GestureDetector(
                            onTap: () {
                              showMoreOptions(context, s);
                            },
                            child: Icon(RemixIcons.more_2_line),
                          )
                        : Container()
                  ],
                ),
                isComment
                    ? Container()
                    : SizedBox(
                        height: 8.h,
                      ),
                feedItem.type == null && !isComment
                    ? BaseText(
                        type: TextTypes.d1,
                        textColor: AntColors.gray8,
                        text: feedItem.message,
                      )
                    : Container()
              ],
            ),
          ),
          feedItem.file != null
              ? Downloader(
                  file: feedItem.file,
                  openFile: true,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.0.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.0.w),
                          child: feedItem.file == null
                              ? Icon(
                                  RemixIcons.attachment_2,
                                  size: 16.sp,
                                  color: AntColors.blue6,
                                )
                              : Icon(
                                  RemixIcons.attachment_2,
                                  size: 16.sp,
                                  color: AntColors.blue6,
                                ),
                        ),
                        Expanded(
                          child: BaseText(
                            // padding: EdgeInsets.zero,
                            text: feedItem.file.name,
                            textColor: AntColors.blue6,
                            type: TextTypes.d1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        )
                      ],
                    ),
                  ),
                  onFinish: () {},
                )
              : Container(),
          isComment ? Container() : _getBottom(s, context),
        ],
      ),
    );
  }

  _getBottom(S s, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 1,
          color: AntColors.gray6,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0.w),
          child: MainTextButton(
            onPress: () {
              onItemClick(comments, feedItem);
            },
            customText: BaseText(
              text: comments != null && comments.length > 0
                  ? s.open_all_comments(comments.length)
                  : s.add_a_comment,
              textColor: AntColors.blue6,
              type: TextTypes.d1,
            ),
          ),
        )
      ],
    );
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    var date =
        formatter.format(DateTime.tryParse(feedItem.createdAt).toLocal()).toString();
    return date;
  }

  _getBody() {
    if (feedItem.type == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            type: TextTypes.d1,
            weightType: FontWeight.w600,
            text: _getTitle(),
            textColor: AntColors.gray8,
          ),
          SizedBox(
            height: 2.h,
          ),
          BaseText(
            type: TextTypes.d2,
            text: _getDate(),
            textColor: AntColors.gray7,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            type: TextTypes.d1,
            weightType: FontWeight.w600,
            text: feedItem.message,
            textColor: AntColors.gray8,
          ),
          SizedBox(
            height: 2.h,
          ),
          BaseText(
            type: TextTypes.d2,
            text: _getDate(),
            textColor: AntColors.gray7,
          ),
        ],
      );
    }
  }

  _getTitle() {
    String firstName =
        feedItem.userCreatedBy != null ? feedItem.userCreatedBy.firstName : "";
    String lastName =
        feedItem.userCreatedBy != null ? feedItem.userCreatedBy.lastName : "";
    return "$firstName $lastName";
  }

  showMoreOptions(BuildContext context, S s) {
    showMaterialModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        backgroundColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return Material(
            child: Container(
              height: 201,
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.0.h),
                        child: Center(
                          child: Container(
                            width: 56.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: AntColors.gray3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.only(
                              top: 16.h, bottom: 16.h, right: 16.w),
                          icon: Icon(RemixIcons.close_fill),
                          iconSize: 24.sp,
                          color: AntColors.gray6,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  isComment
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            editEntry(feedItem.id);
                          },
                          child: Container(
                            height: 44.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                Icon(
                                  RemixIcons.edit_line,
                                  color: AntColors.gray8,
                                  size: 20.sp,
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                BaseText(
                                  text: s.change_comment,
                                  weightType: FontWeight.w500,
                                  textColor: AntColors.gray8,
                                )
                              ],
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _showMaterialDialog(context, s, feedItem.id);
                    },
                    child: Container(
                      height: 44.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          Icon(
                            RemixIcons.delete_bin_7_line,
                            color: AntColors.gray8,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          BaseText(
                            text: s.delete_comment,
                            weightType: FontWeight.w500,
                            textColor: AntColors.gray8,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showMaterialDialog(context, S s, String itemId) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              contentPadding: EdgeInsets.all(16.h),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    RemixIcons.question_fill,
                    color: AntColors.gold6,
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Expanded(
                    child: BaseText(
                      padding: EdgeInsets.zero,
                      text: s.are_you_sure_you_want_to_delete_comment,
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                MainButton(
                  text: s.cancel,
                  ghost: true,
                  size: ButtonSize.Zero,
                  height: 32.h,
                  width: 76.w,
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                ),
                MainButton(
                  text: s.yes_delete,
                  size: ButtonSize.Zero,
                  width: 136.w,
                  height: 32.h,
                  onPress: () {
                    Navigator.of(context).pop();
                    deleteEntry(itemId);
                  },
                )
              ],
            ));
  }
}
