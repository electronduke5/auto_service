import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/services/autoparts_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'autopart_event.dart';

part 'autopart_state.dart';

class AutopartBloc extends Bloc<AutopartEvent, AutopartState> {
  final AutopartService autopartService;

  AutopartBloc({required this.autopartService}) : super(AutopartState()) {
    on<InitialAutopartEvent>((event, emit) => emit(AutopartState()));

    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));

    on<CategoryChanged>(
        (event, emit) => emit(state.copyWith(categoryId: event.category)));

    on<PurchasePriceChanged>((event, emit) =>
        emit(state.copyWith(purchasePrice: event.purchasePrice)));

    on<SalePriceChanged>(
        (event, emit) => emit(state.copyWith(salePrice: event.salePrice)));

    on<CountChanged>((event, emit) => emit(state.copyWith(count: event.count)));

    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<AutopartState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      AutopartDto autopart = await autopartService.addAutopart(
          autopart: AutopartDto(
        name: event.name,
        purchasePrice: event.purchasePrice,
        salePrice: event.salePrice,
        count: event.count,
        category: event.category,
      ));
      emit(state.copyWith(formStatus: FormSubmissionSuccess(autopart)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(AutopartState());
  }
}
