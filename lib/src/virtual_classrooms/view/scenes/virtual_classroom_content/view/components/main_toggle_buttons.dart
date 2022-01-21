import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';
import 'package:flutter/material.dart';

class MainToggleButtons extends StatefulWidget {
  final List<TagsNotAsync> items;
  final int selectedIndex;
  final Function onSelect;

  MainToggleButtons({Key key, this.items, this.selectedIndex, this.onSelect})
      : super(key: key);

  @override
  _MainToggleButtonsState createState() => _MainToggleButtonsState();
}

class _MainToggleButtonsState extends State<MainToggleButtons> {
  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [];
    for (int i = 0; i < widget.items.length; i++) {
      if (i == widget.selectedIndex) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }

    return ToggleButtons(
      borderRadius: BorderRadius.circular(5),
      borderColor: AntColors.gray3,
      selectedBorderColor: AntColors.blue6,
      fillColor: Colors.transparent,
      children: widget.items
          .map(
            (e) => Container(
              width: 70.w,
              child: BaseText(
                  padding: EdgeInsets.zero,
                  text: e.name,
                  fontSize: 14.sp,
                  textColor: AntColors.blue6,
                  align: TextAlign.center),
            ),
          )
          .toList(),
      isSelected: isSelected,
      onPressed: (int index) {
        context.read<VirtualClassroomContentBloc>().add(ClassroomContentTabChanged(index, widget.items[index].id));
      },
    );
  }
}
