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

    on<CarChangedInOrderEvent>(
        (event, emit) => emit(state.copyWith(car: event.car)));
    on<AutopartsChangedInOrderEvent>(
        (event, emit) => emit(state.copyWith(autoparts: event.autoparts)));
    on<ServicesChangedInOrderEvent>(
        (event, emit) => emit(state.copyWith(services: event.services)));
    on<OrderFormSubmittedEvent>((event, emit) => _onFormSubmitted(event, emit));
    on<OrderFormSubmittedUpdateEvent>(
        (event, emit) => _onFormSubmittedUpdate(event, emit));
  }

  void _onFormSubmitted(
      OrderFormSubmittedEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      OrderDto order = await orderService.addOrder(
          order: OrderDto(
              car: event.car,
              carId: event.car.id,
              employee: event.employee,
              employeeId: event.employee.id,
              services: event.services,
              autoparts: event.autoparts,
              status: event.status,
              client: event.car.client));
      emit(state.copyWith(formStatus: FormSubmissionSuccess<OrderDto>(order)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(OrderState());
  }

  void _onFormSubmittedUpdate(
      OrderFormSubmittedUpdateEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      OrderDto order = await orderService.editOrder(
          order: OrderDto(
              id: event.id,
              car: event.car,
              carId: event.car.id,
              employee: event.employee,
              employeeId: event.employee.id,
              services: event.services,
              autoparts: event.autoparts,
              status: event.status,
              client: event.car.client));
      emit(state.copyWith(formStatus: FormSubmissionSuccess<OrderDto>(order)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(OrderState());
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
