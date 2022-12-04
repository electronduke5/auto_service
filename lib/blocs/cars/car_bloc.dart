import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/services/car_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'car_event.dart';

part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarService carService;
  CarBloc({required this.carService}) : super(CarState()) {
    on<GetListCarEvent>((event, emit) => _onGetListCarsEvent(event, emit));
  }

  void _onGetListCarsEvent(
      GetListCarEvent event, Emitter<CarState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<CarDto> cars = await carService.getCars();
      emit(state.copyWith(
          modelsStatus: SubmissionSuccess<CarDto>(listEntities: cars)));
    } catch (error) {
      print(error);
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
