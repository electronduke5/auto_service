import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'receiver_nav_event.dart';

part 'receiver_nav_state.dart';

class ReceiverNavBloc extends Bloc<ReceiverNavEvent, ReceiverNavState> {
  ReceiverNavBloc() : super(ReceiverInViewClientsState()) {
    on<ToViewClientsEvent>((event, emit) => emit(ReceiverInViewClientsState()));
    on<ToViewClientInfoEvent>((event, emit) =>
        emit(ReceiverInViewClientInfoState(client: event.client)));
    on<ToViewCarsEvent>((event, emit) => emit(ReceiverInViewCarsState()));
    on<ToViewOrdersEvent>((event, emit) => emit(ReceiverInViewOrdersState()));
    on<ToAddCarEvent>((event, emit) => emit(ReceiverInAddCarState()));
    on<ToEditCarEvent>(
        (event, emit) => emit(ReceiverInEditCarState(car: event.car)));

    on<ToAddClientEvent>((event, emit) => emit(ReceiverInAddClientState()));
    on<ToEditClientEvent>(
            (event, emit) => emit(ReceiverInEditClientState(client: event.client)));
  }
}
