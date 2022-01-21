import 'package:akademi_al_mobile_app/packages/models/onboarding/wizard.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/packages/models/user/roles.dart';

final navigationItemsIds = [
  "welcome",
  "choose-nationality",
  "profile-picture",
  "choose-level",
  "select-grade",
  "choose-subjects",
  "virtual-classroom",
];

class OnboardingUtils {

  static State getInitialState(List<Roles> roles) {
    final studentsFlows = [
      NavigationItems(
          id: navigationItemsIds[0], priority: 0, status: NavigationItemStatus.Active),
      NavigationItems(
          id: navigationItemsIds[1], priority: 1, status: NavigationItemStatus.Disabled),
      NavigationItems(
          id: navigationItemsIds[2], priority: 2, status: NavigationItemStatus.Disabled),
      NavigationItems(
          id: navigationItemsIds[3], priority: 3, status: NavigationItemStatus.Disabled),
      NavigationItems(
          id: navigationItemsIds[4], priority: 4, status: NavigationItemStatus.Disabled),
      NavigationItems(
          id: navigationItemsIds[5], priority: 5, status: NavigationItemStatus.Disabled),
      NavigationItems(
          id: navigationItemsIds[6], priority: 6, status: NavigationItemStatus.Disabled),
    ];

    return State(
      navigationItems: studentsFlows,
      role: roles[0].code
    );
  }
}
