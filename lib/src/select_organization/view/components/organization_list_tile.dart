import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organization_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizationListTile extends StatefulWidget {
  final OrganizationEntity organizationEntity;
  final Function onClick;

  const OrganizationListTile(
      {Key key, this.organizationEntity, this.onClick})
      : super(key: key);

  @override
  _OrganizationListTileState createState() => _OrganizationListTileState();
}

class _OrganizationListTileState extends State<OrganizationListTile> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          clicked = true;
          widget.onClick.call(widget.organizationEntity.id);
        });
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      tileColor: clicked
          ? AntColors.blue1
          : Colors.white,
      leading: CircleAvatar(
        radius: 20.sp,
        backgroundColor: AntColors.blue2,
        child: Icon(
          RemixIcons.building_4_line,
          size: 16.sp,
          color: AntColors.blue6,
        ),
      ),
      title: BaseText(
        text: widget.organizationEntity.name,
        type: TextTypes.d1,
        textColor: AntColors.gray8,
      ),
      trailing: Icon(
        RemixIcons.arrow_right_s_line,
        color: AntColors.gray7,
        size: 24.sp,
      ),
    );
  }
}
