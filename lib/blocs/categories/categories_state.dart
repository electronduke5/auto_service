part of 'categories_bloc.dart';

class CategoryState {
  final GetModelsStatus modelsStatus;

  CategoryState({this.modelsStatus = const InitialModelsStatus()});

  CategoryState copyWith({GetModelsStatus? modelsStatus}) {
    return CategoryState(modelsStatus: modelsStatus ?? this.modelsStatus);
  }
}
