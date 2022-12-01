import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'receiver_nav_event.dart';

part 'receiver_nav_state.dart';

class ReceiverNavBloc extends Bloc<ReceiverNavEvent, ReceiverNavState> {
  ReceiverNavBloc() : super(ReceiverInViewClientsState()) {
    on<ToViewClientsEvent>((event, emit) => emit(ReceiverInViewClientsState()));
    on<ToViewCarsEvent>((event, emit) => emit(ReceiverInViewCarsState()));
    on<ToViewOrdersEvent>((event, emit) => emit(ReceiverInViewOrdersState()));
  }
}
