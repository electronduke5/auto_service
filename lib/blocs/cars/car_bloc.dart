import 'package:auto_service/blocs/delete_status.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/services/car_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_event.dart';

part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarService carService;

  CarBloc({required this.carService}) : super(CarState()) {
    on<InitialCarEvent>((event, emit) => emit(CarState()));

    on<ModelChanged>((event, emit) => emit(state.copyWith(model: event.model)));
    on<ClientChanged>(
        (event, emit) => emit(state.copyWith(client: event.client)));
    on<VinNumberChanged>(
        (event, emit) => emit(state.copyWith(vinNumber: event.vinNumber)));
    on<CarNumberChanged>(
        (event, emit) => emit(state.copyWith(carNumber: event.carNumber)));
    on<MileageChanged>(
        (event, emit) => emit(state.copyWith(mileage: event.mileage)));
    on<SearchChangedEvent>(
        (event, emit) => emit(state.copyWith(searchQuery: event.searchQuery)));
    on<SearchCarEvent>((event, emit) =>
        _searchCar(event, emit, event.functions, event.searchQuery));
    on<DeleteCarEvent>((event, emit) => _onDeleteCar(event, emit));

    on<GetListCarEvent>((event, emit) => _onGetListCarsEvent(event, emit));

    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));

    on<EditFormCarInitial>((event, emit) => emit(state.copyWith(
          vinNumber: event.car.vinNumber,
          carNumber: event.car.carNumber,
          model: event.car.model,
          mileage: event.car.mileage,
          client: event.car.client,
          formStatus: const InitialFormStatus(),
        )));

    on<FormSubmittedUpdate>(
        (event, emit) => _onFormSubmittedUpdate(event, emit));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<CarState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      CarDto car = await carService.addAutopart(
          car: CarDto(
        model: event.model,
        carNumber: event.carNumber,
        vinNumber: event.vinNumber,
        mileage: event.mileage,
        client: event.client,
        clientId: event.client.id,
      ));
      emit(state.copyWith(formStatus: FormSubmissionSuccess<CarDto>(car)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(CarState());
  }

  void _onFormSubmittedUpdate(
      FormSubmittedUpdate event, Emitter<CarState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      CarDto car = await carService.editCar(
          car: CarDto(
        id: event.id,
        model: event.model,
        carNumber: event.carNumber,
        vinNumber: event.vinNumber,
        mileage: event.mileage,
        client: event.client,
        clientId: event.client.id,
      ));
      emit(state.copyWith(formStatus: FormSubmissionSuccess(car)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(CarState());
  }

  void _onGetListCarsEvent(
      GetListCarEvent event, Emitter<CarState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<CarDto> cars = await carService.getCars();
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<CarDto>(listEntities: cars)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }

  void _searchCar(
      CarEvent event, Emitter<CarState> emit, String func, String query) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<CarDto> cars =
          await carService.getCars(function: func, query: query);
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<CarDto>(listEntities: cars)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }

  void _onDeleteCar(DeleteCarEvent event, Emitter<CarState> emit) async {
    emit(state.copyWith(deleteStatus: SubmittingDelete()));
    try {
      String message = await carService.deleteCar(id: event.id);
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
