part of 'select_organization_bloc.dart';

class SelectOrganizationEvent extends Equatable {
  const SelectOrganizationEvent();

  @override
  List<Object> get props => [];
}


class LoadOrganizationsEvent extends SelectOrganizationEvent {

  @override
  List<Object> get props => [];
}

class ChoosenOrganizationsEvent extends SelectOrganizationEvent {

  final String organizationId;
  final String organizationName;

  ChoosenOrganizationsEvent(this.organizationId, this.organizationName);

  @override
  List<Object> get props => [organizationId, organizationName];
}

class UpdateOrganizationsEvent extends SelectOrganizationEvent {

  final String organizationId;
  final String organizationName;


  UpdateOrganizationsEvent(this.organizationId, this.organizationName);

  @override
  List<Object> get props => [organizationId, organizationName];
}


