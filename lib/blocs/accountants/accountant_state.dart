part of 'accountant_bloc.dart';

class AccountantState {
  final double profit;
  final double expense;
  final String description;
  final DateTime? dateCreated;
  final GetModelsStatus modelsStatus;

  AccountantState({
    this.profit = 0.0,
    this.expense = 0.0,
    this.description = '',
    this.dateCreated,
    this.modelsStatus = const InitialModelsStatus(),
  });

  AccountantState copyWith({
    double? profit,
    double? expense,
    String? description,
    DateTime? dateCreated,
    GetModelsStatus? modelsStatus,

  }) =>
      AccountantState(
          profit: profit ?? this.profit,
          expense: expense ?? this.expense,
          description: description ?? this.description,
          modelsStatus: modelsStatus ?? this.modelsStatus,
          dateCreated: dateCreated ?? this.dateCreated);
}
