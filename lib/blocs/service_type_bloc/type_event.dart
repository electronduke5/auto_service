part of 'type_bloc.dart';

abstract class TypeEvent {}

class GetListTypesEvent extends TypeEvent {}

class DeleteTypeEvent extends TypeEvent {
  final int id;

  DeleteTypeEvent(this.id);
}

class TypeNameChangedEvent extends TypeEvent {
  final String name;

  TypeNameChangedEvent(this.name);
}

class FormSubmittedEvent extends TypeEvent {
  final String name;

  FormSubmittedEvent(this.name);
}

class FormSubmittedUpdateEvent extends TypeEvent {
  final int id;
  final String name;

  FormSubmittedUpdateEvent(this.id, this.name);
}

class EditFormTypeInitialEvent extends TypeEvent {
  final ServiceTypeDto type;

  EditFormTypeInitialEvent(this.type);
}