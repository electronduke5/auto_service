import 'package:auto_service/blocs/delete_status.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/services/client_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientService clientService;

  ClientBloc({required this.clientService}) : super(ClientState()) {
    on<InitialClientEvent>((event, emit) => emit(ClientState()));
    on<ClientSurnameChanged>(
        (event, emit) => emit(state.copyWith(surname: event.surname)));
    on<ClientNameChanged>(
        (event, emit) => emit(state.copyWith(name: event.name)));
    on<ClientPatronymicChanged>(
        (event, emit) => emit(state.copyWith(patronymic: event.patronymic)));
    on<ClientPhoneNumberChanged>(
        (event, emit) => emit(state.copyWith(phoneNumber: event.phoneNumber)));
    on<ClientSearchChanged>(
        (event, emit) => emit(state.copyWith(searchQuery: event.searchQuery)));

    on<EditFormClientInitial>((event, emit) => emit(state.copyWith(
          surname: event.client.surname,
          name: event.client.name,
          patronymic: event.client.patronymic,
          phoneNumber: event.client.phoneNumber,
          formStatus: const InitialFormStatus(),
        )));
    on<ClientFormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
    on<ClientFormSubmittedUpdate>(
        (event, emit) => _onFormSubmittedUpdate(event, emit));
    on<ClientSearchEvent>((event, emit) =>
        _searchClient(event, emit, event.functions, event.searchQuery));

    on<DeleteClientEvent>((event, emit) => _onDeleteCar(event, emit));

    on<GetListClientEvent>(
        (event, emit) => _onGetListClientsEvent(event, emit));
  }

  void _onGetListClientsEvent(
      GetListClientEvent event, Emitter<ClientState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<ClientDto> clients = await clientService.getClients();
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<ClientDto>(listEntities: clients)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }

  void _onFormSubmitted(
      ClientFormSubmitted event, Emitter<ClientState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      ClientDto client = await clientService.addClient(
          client: ClientDto(
        surname: event.surname,
        name: event.name,
        patronymic: event.patronymic,
        phoneNumber: event.phoneNumber,
      ));
      emit(
          state.copyWith(formStatus: FormSubmissionSuccess<ClientDto>(client)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(ClientState());
  }

  void _onFormSubmittedUpdate(
      ClientFormSubmittedUpdate event, Emitter<ClientState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      ClientDto client = await clientService.editClient(
        id: event.id,
        surname: event.surname,
        name: event.name,
        patronymic: event.patronymic,
        phoneNumber: event.phoneNumber,
      );
      emit(state.copyWith(formStatus: FormSubmissionSuccess(client)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(ClientState());
  }

  void _searchClient(ClientEvent event, Emitter<ClientState> emit, String func,
      String query) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<ClientDto> clients =
          await clientService.getClients(function: func, query: query);
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<ClientDto>(listEntities: clients)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }

  void _onDeleteCar(DeleteClientEvent event, Emitter<ClientState> emit) async {
    emit(state.copyWith(deleteStatus: SubmittingDelete()));
    try {
      String message = await clientService.deleteClient(id: event.id);
      emit(state.copyWith(
          deleteStatus: SubmissionDeleteSuccess(successMessage: message)));
    } catch (error) {
      emit(state.copyWith(
          deleteStatus:
              SubmissionDeleteFailed(errorMessage: error.toString())));
      emit(state.copyWith(deleteStatus: const InitialDeleteStatus()));
    }
  }
}
