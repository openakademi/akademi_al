import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:flutter/material.dart';

class KeyboardAwareAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final BaseText title;
  final Widget leading;
  final Widget following;

  const KeyboardAwareAppBar({Key key, this.title, this.leading, this.following})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KeyboardAwareAppBarState();
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}

class _KeyboardAwareAppBarState extends State<KeyboardAwareAppBar>
    with SingleTickerProviderStateMixin {
  bool open = false;

  @override
  void initState() {
    // KeyboardVisibility.onChange.listen((bool visible) {
    //   if (visible) {
    //     setState(() {
    //       open = true;
    //     });
    //   } else {
    //     setState(() {
    //       open = false;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final scrolledPixels = notification.metrics.extentBefore;
            setState(() {
              open = scrolledPixels < 1;
            });
          }
          return false;
        },
        child: SliverAppBar(
          title: widget.title,
          brightness: Brightness.dark,
          elevation: 4,
          backgroundColor: open ? Colors.transparent : Colors.white,
          primary: true,
          leading: widget.leading,
          actions: [if (widget.following != null) widget.following],
          pinned: true,
          flexibleSpace: Container(
            color: Colors.white.withOpacity(open ? 1 : 0),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
