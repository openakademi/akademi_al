import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/input/text_input.dart';
import 'package:akademi_al_mobile_app/components/models/fixed_length_field.dart';
import 'package:akademi_al_mobile_app/components/models/non_empty_field.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organization_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class Code extends FixedLengthField {
  const Code.pure() : super.pure();

  const Code.dirty(value) : super.dirty(value);
}

class JoinClassroom extends StatefulWidget {
  final Function navigate;

  const JoinClassroom({Key key, this.navigate}) : super(key: key);

  @override
  _JoinClassroomState createState() => _JoinClassroomState();
}

class _JoinClassroomState extends State<JoinClassroom> {
  OrganizationRepository organizationRepository;
  ClassroomRepository classroomRepository;
  EnrollmentRepository enrollmentRepository;
  bool loading;
  FormzStatus status;
  Code code;
  String error;

  @override
  void initState() {
    super.initState();
    code = Code.pure();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: 56.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AntColors.gray3),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0.w),
                      child: GestureDetector(
                          child: Icon(
                            RemixIcons.close_fill,
                            size: 24.sp,
                            color: AntColors.gray6,
                          ),
                          onTap: () {
                            if (loading == null || !loading) {
                              Navigator.of(context).pop();
                            }
                          }),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              BaseText(
                text: s.join_virtual_classroom,
                type: TextTypes.h5,
              ),
              SizedBox(
                height: 16.h,
              ),
              Divider(
                color: AntColors.gray4,
                height: 1,
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20.0.w, right: 20.w, bottom: 24.h),
                child: Card(
                  color: AntColors.blue1,
                  elevation: 0,
                  borderOnForeground: true,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: AntColors.blue4),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                          initiallyExpanded: false,
                          leading: Icon(
                            RemixIcons.information_line,
                            color: AntColors.blue6,
                            size: 24.sp,
                          ),
                          title: BaseText(
                            padding:
                                EdgeInsets.only(top: 8, bottom: 8.h, left: 0),
                            text: s.to_enter_virtual_classroom,
                            type: TextTypes.p1,
                            fontSize: 16.sp,
                            textColor: AntColors.gray9,
                          ),
                          children: [
                            Row(children: [
                              SizedBox(
                                width: 60.w,
                              ),
                              Flexible(
                                  child: Padding(
                                padding: EdgeInsets.only(bottom: 16.0.h),
                                child: BaseText(
                                  text:
                                      s.to_enter_virtual_classroom_description,
                                  type: TextTypes.d1,
                                  lineHeight: 1.57,
                                  textColor: AntColors.gray8,
                                  letterSpacing: 0,
                                ),
                              )),
                            ])
                          ]),
                    ],
                  ),
                  // shape:
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: BaseText(
                  text: s.take_code_and_enter_below,
                  type: TextTypes.d1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0.w, right: 20.w, bottom: 26.0.h, top: 16.0.h),
                child: TextInput(
                  prefixIcon: Icon(
                    RemixIcons.door_open_line,
                    size: 20.sp,
                    color: AntColors.gray6,
                  ),
                  errorText: error,
                  height: 54.h,
                  initialValue: code.value,
                  labelText: s.virtual_classroom_code,
                  onChanged: (value) {
                    setState(() {
                      code = Code.dirty(value);
                      error = null;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: MainButton(
                  text: s.login,
                  size: ButtonSize.Medium,
                  width: 335.w,
                  height: 52.h,
                  disabled: !code.valid || loading,
                  onPress: () async {
                    await _enrollToClassroom();
                  },
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  _enrollToClassroom() async {
    setState(() {
      loading = true;
    });

    ClassroomRepository classroomRepository = ClassroomRepository(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context));
    OrganizationRepository organizationRepository = OrganizationRepository(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context));

    ClassroomEntity classroom;
    var myOrganizations = <OrganizationEntity>[];
    OrganizationEntity currentOrg;

    try {
      classroom = await classroomRepository.getClassroomByCode(code.value);
      myOrganizations = await organizationRepository.getMyOrganizations();
      final selectedOrganization = await _tryGetSelectedOrganization();

      currentOrg =
          myOrganizations.firstWhere((item) => item.id == selectedOrganization);
      if (currentOrg.id != classroom.organization.id) {
        setState(() {
          error =
              "Kodi i klasës është i saktë por i përket një institucioni tjetër arsimor. Për të hyrë në këtë klasë, duhet te shkoni tek portali i nxënësit dhe të vendosni kodin e klasës aty!";
          loading = false;
        });
        return;
      }
    } catch (e) {
      print(e);
      setState(() {
        error = "Kursi nuk ekziston";
        loading = false;
      });
      return;
    }

    try {
      final classroomOrgCode = classroom.organization.code;
      EnrollmentRepository enrollmentRepository =
          RepositoryProvider.of<EnrollmentRepository>(context);

      final enrollment =
          await enrollmentRepository.createEnrollment(classroom.id);

      //Join org
      await organizationRepository.joinOrganizationByRole(classroomOrgCode);
    } catch (e) {
      print(e);
      setState(() {
        error = "Dicka shkoi keq";
        loading = false;
      });
      Navigator.of(context).pop();
    }
    setState(() {
      widget.navigate();
      loading = false;
      Navigator.of(context).pop();
    });
  }

  Future<String> _tryGetSelectedOrganization() async {
    OrganizationRepository organizationRepository = OrganizationRepository(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context));
    final selectedOrganization =
        await organizationRepository.getSelectedOrganization();
    return selectedOrganization;
  }
}
