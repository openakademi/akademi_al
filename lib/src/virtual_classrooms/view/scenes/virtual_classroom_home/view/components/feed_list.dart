import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/view/components/feed_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedList extends StatefulWidget {
  final List<FeedItem> feedItems;
  final bool isCommentView;
  final Function(List<FeedItem> comments, FeedItem feedItem) onItemClick;
  final Function itemDelete;
  final Function itemUpdate;
  final String userId;
  final ScrollController scrollController;

  const FeedList(
      {Key key, this.feedItems, this.scrollController, this.isCommentView = false, this.onItemClick, this.userId, this.itemDelete, this.itemUpdate})
      : super(key: key);

  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  List<FeedItem> feedEntries;
  List<FeedItem> feedComments;


  @override
  Widget build(BuildContext context) {
    int length = feedEntries.length;
    return ListView.separated(
      controller: widget.scrollController,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: widget.isCommentView ? 0.h : 24.h,
          );
        },
        itemCount: widget.isCommentView ? length : length + 1,
        itemBuilder: (context, index) {
          if (index == length) {
            if (index != 0) {
              if (widget.scrollController.position.hasContentDimensions) {
              if (context
                  .read<VirtualClassroomHomeBloc>()
                  .state
                  .hasMoreItems &&
                  !widget.scrollController.position.outOfRange) {
                return Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Center(
                      child: LinearProgressIndicator()),
                );
              }
            }
              return Container();
            } else {
              return buildListFeed(index);
            }
          } else if (length == 1) {
            return buildListFeed(index);
          } else {
            return buildListFeed(index);
          }
        });
  }

  Widget buildListFeed(int index){
    final FeedItem item = feedEntries[index];
    final List<FeedItem> comments = feedComments != null ? feedComments
        .where((element) => element.parentId == item.id)
        .toList() : [];
    return FeedEntry(
      feedItem: item,
      comments: comments,
      isComment: widget.isCommentView,
      onItemClick: widget.onItemClick,
      userId: widget.userId,
      deleteEntry: (itemId) {
        widget.itemDelete(item.id);
      },
      editEntry: (itemId) {
        if(widget.itemDelete != null) {
          widget.itemUpdate(item);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isCommentView) {
      feedEntries = widget.feedItems
          .where((element) => element.parentId == null)
          .toList();
      feedEntries.sort((a, b) {
        return DateTime.parse(b.createdAt)
            .compareTo(DateTime.tryParse(a.createdAt));
      });
      feedComments = widget.feedItems
          .where((element) => element.parentId != null)
          .toList();
      feedComments.sort((a, b) {
        return DateTime.parse(b.createdAt)
            .compareTo(DateTime.tryParse(a.createdAt));
      });
    } else {
      feedEntries = widget.feedItems;
      feedEntries.sort((a, b) {
        return DateTime.parse(b.createdAt)
            .compareTo(DateTime.tryParse(a.createdAt));
      });
    }
  }

  @override
  void didUpdateWidget(FeedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feedItems.length != widget.feedItems.length) {
      if (!widget.isCommentView) {
        setState(() {
          feedEntries = widget.feedItems
              .where((element) => element.parentId == null)
              .toList();
          feedEntries.sort((a, b) {
            return DateTime.parse(b.createdAt)
                .compareTo(DateTime.tryParse(a.createdAt));
          });
          feedComments = widget.feedItems
              .where((element) => element.parentId != null)
              .toList();
          feedComments.sort((a, b) {
            return DateTime.parse(b.createdAt)
                .compareTo(DateTime.tryParse(a.createdAt));
          });
        });
      } else {
        setState(() {
          feedEntries = widget.feedItems;
          feedEntries.sort((a, b) {
            return DateTime.parse(b.createdAt)
                .compareTo(DateTime.tryParse(a.createdAt));
          });
        });
      }
    }
  }
}
