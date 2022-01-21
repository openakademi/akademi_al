import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/bloc/async_subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterModal extends StatefulWidget {
  final List<String> filteredSubjects;

  const FilterModal({Key key, this.filteredSubjects}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<String> filteredSubjects;

  @override
  void initState() {
    super.initState();
    filteredSubjects = widget.filteredSubjects != null
        ? List.from(widget.filteredSubjects)
        : List();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<AsyncSubjectBloc, AsyncSubjectState>(
        builder: (context, state) {
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
                  context
                      .read<AsyncSubjectBloc>()
                      .add(FiltersChanged(filteredSubjects));
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
                      onPress: (){
                        context
                            .read<AsyncSubjectBloc>()
                            .add(FiltersChanged(null));
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
          itemCount: state.filters.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              onTap: () {
                final newList = List<String>.from(this.filteredSubjects);
                if (_isSelected(state.filters[position])) {
                  newList.remove(state.filters[position].id);
                } else {
                  newList.add(state.filters[position].id);
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
                      Padding(
                        padding: EdgeInsets.only(right: 16.0.w),
                        child: Center(
                          child: Icon(
                            RemixIcons.MapForm[state.filters[position].icon
                                .replaceAll("-", "_")],
                            size: 24.sp,
                            color: AntColors.gray8,
                          ),
                        ),
                      ),
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
                                  text: state.filters[position].name,
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
                                    color: _isSelected(state.filters[position])
                                        ? AntColors.blue6
                                        : Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.sp)),
                                    border: Border.all(
                                      color:
                                          _isSelected(state.filters[position])
                                              ? AntColors.blue6
                                              : AntColors.gray5,
                                    ),
                                  ),
                                  child: _isSelected(state.filters[position])
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
    });
  }

  _isSelected(AsyncSubject subject) {
    return filteredSubjects.contains(subject.id);
  }

  @override
  void dispose() {
    super.dispose();
    filteredSubjects = [];
  }
}
