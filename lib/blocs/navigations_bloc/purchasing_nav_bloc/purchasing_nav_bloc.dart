import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'purchasing_nav_event.dart';

part 'purchasing_nav_state.dart';

class PurchasingNavBloc extends Bloc<PurchasingNavEvent, PurchasingNavState> {
  PurchasingNavBloc() : super(PurchasingInViewState()) {
    on<ToViewAutopartsPageEvent>((event, emit) => emit(PurchasingInViewState()));
    on<ToAddAutopartPageEvent>((event, emit) => emit(PurchasingInAddState()));
    on<ToEditAutopartsPageEvent>((event, emit) => emit(PurchasingInEditState(autopart: event.autopart)));
  }
}
