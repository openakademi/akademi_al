import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/authorization_token.dart';
import 'package:akademi_al_mobile_app/packages/models/user/roles.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/src/authentication/block/authentication_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/home.dart';
import 'package:akademi_al_mobile_app/src/select_organization/bloc/select_organization_bloc.dart';
import 'package:akademi_al_mobile_app/src/select_organization/view/components/organization_list_tile.dart';
import 'package:akademi_al_mobile_app/src/synchronization/view/synchronization_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectOrganization extends StatefulWidget {
  final bool changeOrg;

  const SelectOrganization({Key key, this.changeOrg}) : super(key: key);

  static Route route(bool changeOrg) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
              create: (context) {
                return SelectOrganizationBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                    organizationRepository: OrganizationRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context)));
              },
              child: SelectOrganization(
                changeOrg: changeOrg,
              ),
            ));
  }

  @override
  _SelectOrganizationState createState() => _SelectOrganizationState();
}

class _SelectOrganizationState extends State<SelectOrganization> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return FutureBuilder<String>(
        future: _router(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 1,
                backgroundColor: Colors.white,
                title: new BaseText(
                  text: s.choose_organization_title,
                  letterSpacing: -0.4,
                  weightType: FontWeight.w600,
                  lineHeight: 1.21,
                ),
              ),
              body: BlocListener<SelectOrganizationBloc,
                  SelectOrganizationState>(listener: (context, state) {
                if (state.done != null && state.done) {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil<void>(
                      SynchronizationPage.route(),
                      (route) => false,
                    );
                  });
                }
              }, child:
                  BlocBuilder<SelectOrganizationBloc, SelectOrganizationState>(
                      builder: (context, state) {
                return state.loading != null && state.loading
                    ? SkeletonList()
                    : SafeArea(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 120.h,
                          color: AntColors.gray2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0.w, top: 32.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0.h),
                                  child: BaseText(
                                    text: s.student_portal(
                                        state.myOrganizations.length),
                                    type: TextTypes.h5,
                                    lineHeight: 1.3,
                                    textColor: AntColors.gray9,
                                  ),
                                ),
                                BaseText(
                                  text: s.choose_organization,
                                  textColor: AntColors.gray8,
                                  type: TextTypes.d1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child:  SingleChildScrollView(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6.sp)),
                                    border: Border.all(
                                      color: AntColors.gray3,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0.h),
                                    child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder:
                                            (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.all(0.0),
                                            child: Divider(
                                              color: AntColors.gray3,
                                              thickness: 1.sp,
                                              height: 1,
                                            ),
                                          );
                                        },
                                        itemCount:
                                            state.myOrganizations != null
                                                ? state.myOrganizations
                                                    .length
                                                : 0,
                                        itemBuilder: (context, index) {
                                          return OrganizationListTile(
                                            organizationEntity: state
                                                .myOrganizations[index],
                                            onClick: state.submitting ==
                                                        null ||
                                                    !state.submitting
                                                ? (organizationId) {
                                                    context
                                                        .read<
                                                            SelectOrganizationBloc>()
                                                        .add(ChoosenOrganizationsEvent(
                                                            organizationId,
                                                            state
                                                                .myOrganizations[
                                                                    index]
                                                                .name));
                                                  }
                                                : null,
                                          );
                                        }),
                                  ),
                                ),
                              )),
                        ),
                      ]),
                    );
              })),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    context.read<SelectOrganizationBloc>().add(LoadOrganizationsEvent());
  }

  Future<String> _router(BuildContext context) async {
    if (widget.changeOrg) {
      return "yes";
    }

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil<void>(
          HomePage.route(true),
          (route) => false,
        );
      });
    }

    AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final roles = await _tryGetRoles(authenticationRepository);
    final token = await _tryGetTokenObject(authenticationRepository);
    final selectedOrganization = await _tryGetSelectedOrganization(authenticationRepository);


    final isMultiOrg = token.organizations != null &&
        roles != null &&
        token.organizations
                .where((element) =>
                    element.parentOrganizationId != null &&
                    roles.any((element1) =>
                        element1.userRoleId == element.userRoleId))
                .length >
            1;

    print("isMutiOrganization $isMultiOrg");
    final automaticallySelectedOrganization = !isMultiOrg &&
            token.organizations != null &&
            token.organizations.length > 1
        ? token.organizations.firstWhere(
            (org) =>
                org.parentOrganizationId != null &&
                roles
                    .any((element1) => element1.userRoleId == org.userRoleId),
            orElse: () => null)
        : null;

    print("isMutiOrganization $automaticallySelectedOrganization");
    print("isMutiOrganization ${token.organizations}");
    print("isMutiOrganization roles ${roles}");

    if (selectedOrganization != null) {
      await authenticationRepository.refreshToken(selectedOrganization);
      context
          .read<SelectOrganizationBloc>()
          .add(UpdateOrganizationsEvent(selectedOrganization, null));
    }

    if (automaticallySelectedOrganization != null) {
      await authenticationRepository
          .refreshToken(automaticallySelectedOrganization.organizationId);
      context.read<SelectOrganizationBloc>().add(UpdateOrganizationsEvent(
          automaticallySelectedOrganization.organizationId,
          automaticallySelectedOrganization.name));
    }

    if (isMultiOrg &&
        selectedOrganization == null &&
        automaticallySelectedOrganization == null) {
      return "yes";
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil<void>(
          SynchronizationPage.route(),
          (route) => false,
        );
      });
    }
    return "yes";
  }


  Future<List<Roles>> _tryGetRoles(AuthenticationRepository authenticationRepository) async {
    final roles = await authenticationRepository.getCurrentUserRole();
    return roles;
  }

  Future<AuthorizationToken> _tryGetTokenObject(AuthenticationRepository authenticationRepository) async {
    final token = await authenticationRepository.getTokenObject();
    return token;
  }

  Future<String> _tryGetSelectedOrganization(AuthenticationRepository authenticationRepository) async {
    final OrganizationRepository organizationRepository = OrganizationRepository(authenticationRepository: authenticationRepository);
    final selectedOrganization = await organizationRepository.getSelectedOrganization();
    return selectedOrganization;
  }


}
