part of 'categories_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetListCategoriesEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;

  DeleteCategoryEvent(this.id);
}

class CategoryNameChangedEvent extends CategoryEvent {
  final String name;

  CategoryNameChangedEvent(this.name);
}

class FormSubmittedEvent extends CategoryEvent {
  final String name;

  FormSubmittedEvent(this.name);
}

class FormSubmittedUpdateEvent extends CategoryEvent {
  final int id;
  final String name;

  FormSubmittedUpdateEvent(this.id, this.name);
}

class EditFormCategoryInitialEvent extends CategoryEvent {
  final CategoryDto category;

  EditFormCategoryInitialEvent(this.category);
}

class InitialCategoryEvent extends CategoryEvent {
  final CategoryState categoryState;

  InitialCategoryEvent(this.categoryState);
}
