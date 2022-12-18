import 'dart:async';

import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/accountant_dto.dart';
import 'package:auto_service/services/accountant_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accountant_event.dart';
part 'accountant_state.dart';

class AccountantBloc extends Bloc<AccountantEvent, AccountantState> {
  final AccountantService accountantService;

  AccountantBloc(this.accountantService) : super(AccountantState()) {
    on<GetAllListEvent>((event, emit) =>_onGetAllListEvent(event, emit));
  }

  void _onGetAllListEvent(
      GetAllListEvent event, Emitter<AccountantState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<AccountantDto> accountants = await accountantService.getAccountants();

      emit(state.copyWith(
          modelsStatus:
          SubmissionSuccess<AccountantDto>(listEntities: accountants)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}


