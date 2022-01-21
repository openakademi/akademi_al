import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyboardAwareLayout extends StatefulWidget {
  final BaseText title;
  final Widget leading;
  final Widget following;
  final Widget body;
  final AssetImage backgroundImage;
  final Widget bottomBar;
  final Widget disclaimer;

  const KeyboardAwareLayout(
      {Key key,
      this.title,
      this.leading,
      this.following,
      this.body,
      this.backgroundImage,
      this.bottomBar,
      this.disclaimer})
      : super(key: key);

  @override
  _KeyboardAwareLayoutState createState() => _KeyboardAwareLayoutState();
}

class _KeyboardAwareLayoutState extends State<KeyboardAwareLayout>
    with TickerProviderStateMixin {
  AnimationController _colorAnimationController;
  Animation _colorTween;
  ScrollController _controller;

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_colorAnimationController);
    _controller = new ScrollController();
    KeyboardVisibility.onChange.listen((bool visible) {
      if (visible) {
      } else {
        setState(() {
          _controller.animateTo(0.0,
              duration: Duration(milliseconds: 20), curve: Curves.easeIn);
          _colorAnimationController.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      persistentFooterButtons: (widget.disclaimer != null)? [
         widget.disclaimer
      ]: null,
      bottomNavigationBar: widget.bottomBar != null
          ? Container(
              height: 108.h,
              color: AntColors.blue1,
              child: widget.bottomBar,
            )
          : null,
      // extendBodyBehindAppBar: true,
      body: NotificationListener<ScrollNotification>(
          onNotification: (Notification scrollInfo) {
            if (scrollInfo is ScrollNotification &&
                scrollInfo.metrics.axis == Axis.vertical) {
              if (scrollInfo.metrics.pixels > 0) {
                if (!_colorAnimationController.isAnimating) {
                  setState(() {
                    _colorAnimationController.forward();
                  });
                }
              }
            }
            return false;
          },
          child: Stack(children: [
            if (widget.backgroundImage != null)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.backgroundImage,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            CustomScrollView(
                controller: _controller,
                shrinkWrap: false,
                anchor: 0.0,
                physics: const ScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: widget.title,
                    elevation: 3,
                    backgroundColor: _colorTween.value,
                    leading: widget.leading,
                    actions: [if (widget.following != null) widget.following],
                    pinned: true,
                  ),
                  SliverToBoxAdapter(child: widget.body)
                ]),
          ])),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }
}
