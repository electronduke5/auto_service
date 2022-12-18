import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accountant_nav_event.dart';
part 'accountant_nav_state.dart';

class AccountantNavBloc extends Bloc<AccountantNavEvent, AccountantNavState> {
  AccountantNavBloc() : super(AccountantInViewAllState()) {
    on<ToViewAllEvent>((event, emit) => emit(AccountantInViewAllState()));
    on<ToExportEvent>((event, emit) => emit(AccountantInExportState()));
    on<ToViewExpenseEvent>((event, emit) => emit(AccountantInViewExpenseState()));
    on<ToViewProfitEvent>((event, emit) => emit(AccountantInViewProfitState()));
    on<ToViewChartEvent>((event, emit) => emit(AccountantInViewChartState()));
  }
}
