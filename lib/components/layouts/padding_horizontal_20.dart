import 'package:flutter/material.dart';

class PaddingHorizontal extends StatelessWidget {
  final Widget child;
  final Widget appBar;

  const PaddingHorizontal({Key key, this.child, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          appBar,
          SliverFillRemaining(
            child: child,
          ),
        ]);
  }
}
