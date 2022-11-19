import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/services/autoparts_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_autoparts_event.dart';

part 'view_autoparts_state.dart';

class ViewAutopartsBloc extends Bloc<ViewAutopartsEvent, ViewAutopartsState> {
  final AutopartService autopartsService;

  ViewAutopartsBloc({required this.autopartsService})
      : super(ViewAutopartsState()) {
    on<GetListAutopartsEvent>(
        (event, emit) => _onGetListAutopartsEvent(event, emit));
  }

  void _onGetListAutopartsEvent(
      ViewAutopartsEvent event, Emitter<ViewAutopartsState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<AutopartDto> autoparts = await autopartsService.getAutoparts();

      emit(state.copyWith(
          modelsStatus:
              SubmissionSuccess<AutopartDto>(listEntities: autoparts)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
