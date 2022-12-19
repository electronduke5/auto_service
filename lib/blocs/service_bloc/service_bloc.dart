import 'package:auto_service/blocs/delete_status.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/services/repair_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final RepairService repairService;

  ServiceBloc({required this.repairService}) : super(ServiceState()) {
    on<GetListServicesEvent>((event, emit) async {
      emit(state.copyWith(modelsStatus: Submitting()));
      try {
        List<ServiceDto> services = await repairService.getServices();
        emit(state.copyWith(
            modelsStatus:
                SubmissionSuccess<ServiceDto>(listEntities: services)));
      } catch (error) {
        emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
      }
    });
    on<InitialServiceEvent>((event, emit) =>
        emit(state.copyWith(modelsStatus: const InitialModelsStatus())));

    on<ServiceDescriptionChangedEvent>(
        (event, emit) => emit(state.copyWith(description: event.description)));

    on<ServicePriceChangedEvent>(
        (event, emit) => emit(state.copyWith(price: event.price)));

    on<ServiceTypeChangedEvent>(
        (event, emit) => emit(state.copyWith(type: event.type)));
    on<DeleteServiceEvent>((event, emit) => _onDeleteService(event, emit));
    on<FormSubmittedEvent>((event, emit) => _onFormSubmitted(event, emit));
    on<FormSubmittedUpdateEvent>(
        (event, emit) => _onFormSubmittedUpdate(event, emit));
    on<EditFormServiceInitialEvent>(
      (event, emit) => emit(
        state.copyWith(
          price: event.service.price,
          type: event.service.type,
          description: event.service.description,
          formStatus: const InitialFormStatus(),
        ),
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmittedEvent event, Emitter<ServiceState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      ServiceDto service = await repairService.addService(
          service: ServiceDto(
        description: event.description,
        type: event.type,
        price: event.price,
        serviceTypeId: event.type.id,
      ));
      emit(state.copyWith(
          formStatus: FormSubmissionSuccess<ServiceDto>(service)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(ServiceState());
  }

  void _onFormSubmittedUpdate(
      FormSubmittedUpdateEvent event, Emitter<ServiceState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      ServiceDto service = await repairService.editService(
          service: ServiceDto(
        id: event.id,
        description: event.description,
        type: event.type,
        price: event.price,
        serviceTypeId: event.type.id,
      ));
      emit(state.copyWith(
          formStatus: FormSubmissionSuccess<ServiceDto>(service)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(ServiceState());
  }

  void _onDeleteService(
      DeleteServiceEvent event, Emitter<ServiceState> emit) async {
    emit(state.copyWith(deleteStatus: SubmittingDelete()));
    try {
      String message = await repairService.deleteService(id: event.id);
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
