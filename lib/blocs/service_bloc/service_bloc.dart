import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/services/repair_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    on<InitialServiceEvent>((event,emit) => emit(state.copyWith(modelsStatus: const InitialModelsStatus())));
  }
}
