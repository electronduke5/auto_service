part of 'car_bloc.dart';

@immutable
abstract class CarEvent {}

class GetListCarEvent extends CarEvent {}

class DeleteCarEvent extends CarEvent {
  final int id;

  DeleteCarEvent(this.id);
}

class SearchChangedEvent extends CarEvent {
  final String searchQuery;

  SearchChangedEvent(this.searchQuery);
}

class SearchCarEvent extends CarEvent {
  final String functions = 'search';
  final String searchQuery;

  SearchCarEvent({required this.searchQuery});
}

class InitialCarEvent extends CarEvent {
  final CarState carState;

  InitialCarEvent(this.carState);
}

//Change Field
class CarNumberChanged extends CarEvent {
  final String carNumber;

  CarNumberChanged(this.carNumber);
}

class ClientChanged extends CarEvent {
  final ClientDto client;

  ClientChanged(this.client);
}

class ModelChanged extends CarEvent {
  final String model;

  ModelChanged(this.model);
}

class VinNumberChanged extends CarEvent {
  final String vinNumber;

  VinNumberChanged(this.vinNumber);
}

class MileageChanged extends CarEvent {
  final double mileage;

  MileageChanged(this.mileage);
}

//Edit Events

class EditFormCarInitial extends CarEvent {
  final CarDto car;

  EditFormCarInitial(this.car);
}

class FormSubmittedUpdate extends CarEvent {
  final int id;
  final String model;
  final String carNumber;
  final String vinNumber;
  final double mileage;
  final ClientDto client;

  //final CarDto car;

  FormSubmittedUpdate(
      {required this.id,
      required this.model,
      required this.carNumber,
      required this.vinNumber,
      required this.mileage,
      //required this.car,
      required this.client});
}

class FormSubmitted extends CarEvent {
  final String model;
  final String carNumber;
  final String vinNumber;
  final double mileage;
  final ClientDto client;

  FormSubmitted(
      {required this.model,
      required this.carNumber,
      required this.vinNumber,
      required this.mileage,
      required this.client});
}
