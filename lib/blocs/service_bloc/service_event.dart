part of 'service_bloc.dart';

abstract class ServiceEvent {}

class GetListServicesEvent extends ServiceEvent {}

class InitialServiceEvent extends ServiceEvent {}

class DeleteServiceEvent extends ServiceEvent {
  final int id;

  DeleteServiceEvent(this.id);
}

class ServiceDescriptionChangedEvent extends ServiceEvent {
  final String description;

  ServiceDescriptionChangedEvent(this.description);
}

class ServicePriceChangedEvent extends ServiceEvent {
  final double price;

  ServicePriceChangedEvent(this.price);
}

class ServiceTypeChangedEvent extends ServiceEvent {
  final ServiceTypeDto type;

  ServiceTypeChangedEvent(this.type);
}

class FormSubmittedEvent extends ServiceEvent {
  final String description;
  final ServiceTypeDto type;
  final double price;

  FormSubmittedEvent(this.description, this.type, this.price);
}

class FormSubmittedUpdateEvent extends ServiceEvent {
  final int id;
  final String description;
  final ServiceTypeDto type;
  final double price;

  FormSubmittedUpdateEvent({
    required this.id,
    required this.description,
    required this.type,
    required this.price,
  });
}

class EditFormServiceInitialEvent extends ServiceEvent {
  final ServiceDto service;

  EditFormServiceInitialEvent(this.service);
}
