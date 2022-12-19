import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'storekeeper_nav_event.dart';
part 'storekeeper_nav_state.dart';

class StorekeeperNavBloc extends Bloc<StorekeeperNavEvent, StorekeeperNavState> {
  StorekeeperNavBloc() : super(StorekeeperInViewState()) {
    on<ToViewAutopartsEvent>((event, emit) => emit(StorekeeperInViewState()));
    on<ToViewCategoriesEvent>((event, emit) => emit(StorekeeperInViewCategoriesState()));
    on<ToViewServicesEvent>((event, emit) => emit(StorekeeperInViewServicesState()));
    on<ToViewTypesEvent>((event, emit) => emit(StorekeeperInViewTypesState()));
    on<ToEditAutopartEvent>((event, emit) => emit(StorekeeperInEditState(autopartEdit: event.autopart)));
  }
}
