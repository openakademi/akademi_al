import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/grid_skeleton.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/bloc/async_subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'components/filter_modal.dart';
import 'components/search_input.dart';
import 'components/subject_tile.dart';

class SubjectsScene extends StatefulWidget {
  final bool search;

  const SubjectsScene({
    Key key, this.search = true,
  }) : super(key: key);

  @override
  SubjectsSceneState createState() => SubjectsSceneState();
}

class SubjectsSceneState extends State<SubjectsScene> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<AsyncSubjectBloc, AsyncSubjectState>(
        buildWhen: (previous, next) {
      return previous.asyncSubjects?.length != next.asyncSubjects?.length;
    }, builder: (context, state) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
              child: BaseText(
                text: s.subjects_browser_description,
                type: TextTypes.d1,
                textColor: AntColors.gray8,
              ),
            ),
            widget.search ? SearchInput(): Container(),
            Divider(
              color: AntColors.gray5,
              thickness: 1,
            ),
            state.asyncSubjects == null
                ? Expanded(
              child: SkeletonGrid(),
            )
                : Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: state.asyncSubjects == null
                    ? 0
                    : state.asyncSubjects?.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.h,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 1.25),
                itemBuilder: (BuildContext context, int index) {
                  return SubjectTile(
                    subject: state.asyncSubjects[index],
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }

  showFilterBottomSheet() {
    showCupertinoModalBottomSheet(
        context: this.context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return BlocProvider.value(
              value: context.read<AsyncSubjectBloc>(),
              child: BlocBuilder<AsyncSubjectBloc, AsyncSubjectState>(
                  builder: (context, state) {
                return FilterModal(filteredSubjects: state.filteredSubjects);
              }));
        });
  }

  @override
  void initState() {
    super.initState();
    context.read<AsyncSubjectBloc>().add(LoadAsyncSubjectsEvent());
  }
}
