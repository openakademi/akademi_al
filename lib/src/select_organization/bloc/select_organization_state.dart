part of 'select_organization_bloc.dart';

class SelectOrganizationState extends Equatable {
  const SelectOrganizationState({this.loading, this.myOrganizations, this.submitting, this.done});

  final bool loading;
  final bool submitting;
  final List<OrganizationEntity> myOrganizations;
  final bool done;

  SelectOrganizationState copyWith({
    bool loading,
    List<OrganizationEntity> myOrganizations,
    bool submitting,
    bool done
  }) {
    return new SelectOrganizationState(
      loading: loading ?? this.loading,
      myOrganizations: myOrganizations ?? this.myOrganizations,
      submitting: submitting ?? this.submitting,
      done: done ?? this.done,
    );
  }

  @override
  List<Object> get props => [loading, myOrganizations, submitting, done];
}
