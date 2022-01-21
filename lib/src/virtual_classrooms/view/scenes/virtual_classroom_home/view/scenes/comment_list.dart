import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/user_avatar/user_avatar.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/view/components/feed_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommentList extends StatefulWidget {
  const CommentList(
      {Key key,
      this.comments,
      this.entry,
      this.onAddComment,
      this.userId,
      this.deleteItem})
      : super(key: key);

  static Route route(List<FeedItem> comments, FeedItem entry,
      Function onAddComment, String userId, Function deleteItem) {
    return MaterialPageRoute<void>(
        builder: (_) => CommentList(
              comments: comments,
              entry: entry,
              onAddComment: onAddComment,
              userId: userId,
              deleteItem: deleteItem,
            ));
  }

  final List<FeedItem> comments;
  final FeedItem entry;
  final Function onAddComment;
  final String userId;
  final Function deleteItem;

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  String comment;
  TextEditingController _controller;
  List<FeedItem> comments;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          elevation: 1,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                RemixIcons.arrow_left_line,
                color: AntColors.blue6,
                size: 24.sp,
              ),
            ),
          ),
          title: BaseText(
            text: s.add_a_comment_title,
            textColor: AntColors.gray9,
          )),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0.w, right: 16.w, top: 16.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: widget.entry.type != null
                                      ? TypeItem(
                                          itemType: widget.entry.type,
                                          size: 20.h,
                                        )
                                      : UserAvatar(
                                          userId: widget.entry.userId,
                                          height: 40.h,
                                          width: 40.w,
                                        )),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(child: _getBody())
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          widget.entry.type == null
                              ? BaseText(
                                  type: TextTypes.d1,
                                  textColor: AntColors.gray8,
                                  text: widget.entry.message,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Divider(
                  height: 1,
                  color: AntColors.gray6,
                ),
                Expanded(
                  child: FeedList(
                    feedItems: comments,
                    isCommentView: true,
                    userId: widget.userId,
                    itemDelete: (itemId) {
                      setState(() {
                        comments.removeWhere((element) => element.id == itemId);
                        comments = comments;
                        widget.deleteItem(itemId);
                      });
                    }
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: _getCommentInput(s),
          ),
        ],
      ),
    );
  }

  _getBody() {
    if (widget.entry.type == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            type: TextTypes.h6,
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
            type: TextTypes.h6,
            weightType: FontWeight.w600,
            text: widget.entry.message,
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

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    var date =
        formatter.format(DateTime.tryParse(widget.entry.createdAt)).toString();
    return date;
  }

  _getTitle() {
    String firstName = widget.entry.userCreatedBy != null
        ? widget.entry.userCreatedBy.firstName
        : "";
    String lastName = widget.entry.userCreatedBy != null
        ? widget.entry.userCreatedBy.lastName
        : "";
    return "$firstName $lastName";
  }

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
    comments = widget.comments;
  }

  @override
  void didUpdateWidget(CommentList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.comments.length != widget.comments.length) {
      setState(() {
        comments = widget.comments;
      });
    }
  }

  _getCommentInput(S s) {
    return Material(
      color: Colors.white,
      child: Container(
        height: 56.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: TextField(
              controller: _controller,
              enableSuggestions: false,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: s.add_a_comment,
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: comment == null || comment.isEmpty
                        ? null
                        : () {
                            _onPressed();
                          },
                    disabledColor: AntColors.gray3,
                    iconSize: 18.sp,
                    icon: Icon(
                      RemixIcons.send_plane_2_line,
                      color: comment == null || comment.isEmpty
                          ? AntColors.gray7
                          : AntColors.blue6,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  _onPressed() async {
    FeedItem feedItem = FeedItem(
      message: comment,
      parentId: widget.entry.id,
      createdAt: DateTime.now().toString(),
    );
    widget.onAddComment(feedItem);
    _controller.text = "";
    final authenticationRepository =
        await RepositoryProvider.of<AuthenticationRepository>(context);
    final currentUser = await authenticationRepository.getCurrentUser();
    var createdBy = UserCreatedBy(
        firstName: currentUser.firstName, lastName: currentUser.lastName);
    feedItem.userCreatedBy = createdBy;
    setState(() {
      comment = "";
    });
    setState(() {
      comments = [...comments, feedItem];
    });
  }
}
