import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/onboarding/wizard.dart';
import 'package:akademi_al_mobile_app/packages/models/user/roles.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import 'utils.dart';

const path = "/onboarding";

class OnboardingApiProvider extends ApiServiceData {
  OnboardingApiProvider(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<Wizard> getWizard() async {
    final wizard = await this.getRequest("$path/wizard");
    return Wizard.fromJson(wizard);
  }

  createWizard(List<Roles> role) async {
    var state = OnboardingUtils.getInitialState(role);
    var uuid = Uuid().v4().toString();
    var wizardDto = Wizard(id: uuid, state: state, wizardType: "ONBOARDING");

    final wizard = await this.post("$path/wizard", wizardDto.toJson());
    return Wizard.fromJson(wizard);
  }

  updateWizard(Wizard updateWizard) async {
    await this.update("$path/wizard/${updateWizard.id}",
        {"id": updateWizard.id, "State": jsonEncode(updateWizard.state.toJson()).toString()});
  }

  getAllGrades() async {
    final grades = await this.getRequest("$path/grades");
    return grades;
  }

  getSubjectsBasedOnGrade(String gradeId) async {
    final subjects = await this.getRequest("$path/subjects/$gradeId");
    return subjects;
  }

  finish(Wizard wizard) async {
    var test = wizard.toFinishDtoJson();
    await this.post("$path/finish", test);
  }
}
