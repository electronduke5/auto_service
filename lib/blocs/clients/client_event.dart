part of 'client_bloc.dart';

@immutable
abstract class ClientEvent {}

class GetListClientEvent extends ClientEvent {}

class DeleteClientEvent extends ClientEvent {
  final int id;

  DeleteClientEvent(this.id);
}

class ClientSurnameChanged extends ClientEvent {
  final String surname;

  ClientSurnameChanged(this.surname);
}

class ClientNameChanged extends ClientEvent {
  final String name;

  ClientNameChanged(this.name);
}

class ClientPatronymicChanged extends ClientEvent {
  final String patronymic;

  ClientPatronymicChanged(this.patronymic);
}

class ClientPhoneNumberChanged extends ClientEvent {
  final String phoneNumber;

  ClientPhoneNumberChanged(this.phoneNumber);
}

class ClientSearchChanged extends ClientEvent {
  final String searchQuery;

  ClientSearchChanged(this.searchQuery);
}

class ClientSearchEvent extends ClientEvent {
  final String functions = 'search';
  final String searchQuery;

  ClientSearchEvent({required this.searchQuery});
}

class InitialClientEvent extends ClientEvent {
  final ClientState clientState;

  InitialClientEvent(this.clientState);
}

class EditFormClientInitial extends ClientEvent {
  final ClientDto client;

  EditFormClientInitial(this.client);
}

class ClientFormSubmittedUpdate extends ClientEvent {
  final int id;
  final String surname;
  final String name;
  final String patronymic;
  final String phoneNumber;

  ClientFormSubmittedUpdate({
    required this.surname,
    required this.id,
    required this.name,
    required this.patronymic,
    required this.phoneNumber,
  });
}

class ClientFormSubmitted extends ClientEvent {
  final String surname;
  final String name;
  final String patronymic;
  final String phoneNumber;

  ClientFormSubmitted({
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phoneNumber,
  });
}
