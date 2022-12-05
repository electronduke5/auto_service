import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/autopart_order_dto.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/data/dto/service_order_dto.dart';
import 'package:auto_service/services/order_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderService orderService;

  OrderBloc({required this.orderService}) : super(OrderState()) {
    on<GetListOrdersEvent>((event, emit) => _onGetListOrderEvent(event, emit));

    on<GetOrdersByCarEvent>((event, emit) =>
        _onGetOrderEvent(event, emit, 'filter', event.id.toString()));
  }

  void _onGetListOrderEvent(
      GetListOrdersEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<OrderDto> orders = await orderService.getOrders();
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<OrderDto>(listEntities: orders)));
    } catch (error) {
      print(error);
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }

  void _onGetOrderEvent(GetOrdersByCarEvent event, Emitter<OrderState> emit,
      String func, String query) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<OrderDto> orders =
          await orderService.getOrders(function: func, query: query);
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<OrderDto>(listEntities: orders)));
    } catch (error) {
      print(error);
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
