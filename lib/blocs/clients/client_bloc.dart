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
      print(error);
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
