part of 'view_autoparts_bloc.dart';

class ViewAutopartsState {
  final GetModelsStatus modelsStatus;

  ViewAutopartsState({this.modelsStatus = const InitialModelsStatus()});

  ViewAutopartsState copyWith({GetModelsStatus? modelsStatus}) {
    return ViewAutopartsState(modelsStatus: modelsStatus ?? this.modelsStatus);
  }
}
