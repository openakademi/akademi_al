import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeworkFilter extends StatefulWidget {
  final List<String> filteredSubjects;
  final VirtualClassroomHomeworkState state;
  final Function addFilters;
  final Function deleteFilters;

  const HomeworkFilter(
      {Key key,
        this.filteredSubjects,
        this.state,
        this.addFilters,
        this.deleteFilters})
      : super(key: key);

  @override
  _HomeworkFilterState createState() => _HomeworkFilterState(state);
}

class _HomeworkFilterState extends State<HomeworkFilter> {
  List<String> filteredSubjects;
  final VirtualClassroomHomeworkState state;
  List<String> filterOptions;

  _HomeworkFilterState(this.state);

  @override
  void initState() {
    super.initState();
    filteredSubjects = widget.state.filters != null
        ? List.from(widget.state.filters)
        : List();
    filterOptions = ["EVALUATED", "NOT_EVALUATED", "NOT_COMMITED"];
  }

  @override
  Widget build(BuildContext context) {
    final idToName = {
      "EVALUATED" : "Korrigjuar",
      "NOT_EVALUATED" : "Pa korrigjuar",
      "NOT_COMMITED":"Pa dorëzuar"
    };
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 108.h,
        decoration: BoxDecoration(color: AntColors.blue1, boxShadow: [
          BoxShadow(
            color: AntColors.boxShadow,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, -2),
          )
        ]),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: MainButton(
              text: filteredSubjects != null
                  ? s.apply_filters_number(filteredSubjects.length)
                  : s.apply_filters,
              size: ButtonSize.Medium,
              height: 52.h,
              onPress: () {
                widget.addFilters(filteredSubjects);
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              RemixIcons.arrow_left_line,
              color: AntColors.blue6,
              size: 24.sp,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          filteredSubjects.length != 0
              ? Padding(
            padding: EdgeInsets.only(right: 20.0.w),
            child: MainTextButton(
              onPress: () {
                widget.addFilters(null);

                setState(() {
                  filteredSubjects = [];
                });
              },
              customText: BaseText(
                text: s.remove_filters(filteredSubjects.length),
                textColor: AntColors.blue6,
                type: TextTypes.p1,
              ),
            ),
          )
              : Container()
        ],
        title: BaseText(
          text: s.filter,
          weightType: FontWeight.w600,
          fontSize: 17.sp,
          lineHeight: 1.3,
        ),
      ),
      body: ListView.builder(
        itemCount: filterOptions.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              final newList = List<String>.from(this.filteredSubjects);
              if (_isSelected(filterOptions[position])) {
                newList.remove(filterOptions[position]);
              } else {
                newList.add(filterOptions[position]);
              }
              setState(() {
                filteredSubjects = newList;
              });
            },
            child: Container(
              height: 72.h,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 72.h,
                        decoration: new BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: AntColors.gray3,
                                ))),
                        child: Row(
                          children: [
                            Expanded(
                              child: BaseText(
                                text: idToName[filterOptions[position]],
                                overflow: TextOverflow.ellipsis,
                                type: TextTypes.p1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Container(
                                width: 24.0.sp,
                                height: 24.0.sp,
                                decoration: new BoxDecoration(
                                  color: _isSelected(filterOptions[position])
                                      ? AntColors.blue6
                                      : Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.sp)),
                                  border: Border.all(
                                    color: _isSelected(filterOptions[position])
                                        ? AntColors.blue6
                                        : AntColors.gray5,
                                  ),
                                ),
                                child: _isSelected(filterOptions[position])
                                    ? Icon(
                                  RemixIcons.check_line,
                                  color: Colors.white,
                                  size: 16.sp,
                                )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _isSelected(String subject) {
    return filteredSubjects.contains(subject);
  }

  @override
  void didUpdateWidget(HomeworkFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      filteredSubjects = widget.state.filters != null
          ? List.from(widget.state.filters)
          : List();
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("heree ${widget.state.filters}");
    setState(() {
      filteredSubjects = widget.state.filters != null
          ? List.from(widget.state.filters)
          : List();
    });
  }

  @override
  void dispose() {
    super.dispose();
    filteredSubjects = [];
  }
}
