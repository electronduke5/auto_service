import 'package:auto_service/blocs/delete_status.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/services/repair_type_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'type_event.dart';

part 'type_state.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  final RepairTypeService typeService;

  TypeBloc({required this.typeService}) : super(TypeState()) {
    on<GetListTypesEvent>((event, emit) => _onGetListTypesEvent(event, emit));

    on<TypeNameChangedEvent>(
        (event, emit) => emit(state.copyWith(name: event.name)));
    on<DeleteTypeEvent>((event, emit) => _onDeleteType(event, emit));
    on<FormSubmittedEvent>((event, emit) => _onFormSubmitted(event, emit));
    on<FormSubmittedUpdateEvent>(
        (event, emit) => _onFormSubmittedUpdate(event, emit));
    on<EditFormTypeInitialEvent>(
      (event, emit) => emit(
        state.copyWith(
          name: event.type.name,
          formStatus: const InitialFormStatus(),
        ),
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmittedEvent event, Emitter<TypeState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      ServiceTypeDto type =
          await typeService.addType(type: ServiceTypeDto(name: event.name));
      emit(state.copyWith(
          formStatus: FormSubmissionSuccess<ServiceTypeDto>(type)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(TypeState());
  }

  void _onFormSubmittedUpdate(
      FormSubmittedUpdateEvent event, Emitter<TypeState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      ServiceTypeDto type = await typeService.editType(
          type: ServiceTypeDto(id: event.id, name: event.name));
      emit(state.copyWith(
          formStatus: FormSubmissionSuccess<ServiceTypeDto>(type)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
  }

  void _onDeleteType(DeleteTypeEvent event, Emitter<TypeState> emit) async {
    emit(state.copyWith(deleteStatus: SubmittingDelete()));
    try {
      String message = await typeService.deleteType(id: event.id);
      emit(state.copyWith(
          deleteStatus: SubmissionDeleteSuccess(successMessage: message)));
    } catch (error) {
      emit(state.copyWith(
          deleteStatus:
              SubmissionDeleteFailed(errorMessage: error.toString())));
      emit(state.copyWith(deleteStatus: const InitialDeleteStatus()));
    }
  }

  void _onGetListTypesEvent(TypeEvent event, Emitter<TypeState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<ServiceTypeDto> types = await typeService.getTypes();
      emit(state.copyWith(
          modelsStatus:
              SubmissionSuccess<ServiceTypeDto>(listEntities: types)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
