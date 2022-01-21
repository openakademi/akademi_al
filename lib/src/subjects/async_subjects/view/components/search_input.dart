
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/bloc/async_subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return  Padding(
      padding: EdgeInsets.only(bottom: 12.0.h, left: 16.w, right: 16.w),
      child: TextInput(
        prefixIcon: Icon(
          RemixIcons.search_2_line,
          color: AntColors.gray6,
          size: 20.sp,
        ),
        height: 40.h,
        onChanged: (search) => context
            .bloc<AsyncSubjectBloc>()
            .add(SearchInputChanged(search)),
        hintText: s.search,
        hintStyle: defaultTextStyles[TextTypes.p2].copyWith(color: AntColors.gray6),
      ),
    );
  }

}