import 'package:auto_service/blocs/delete_status.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/services/category_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;

  CategoryBloc({required this.categoryService}) : super(CategoryState()) {
    on<GetListCategoriesEvent>(
        (event, emit) => _onGetListCategoriesEvent(event, emit));

    on<InitialCategoryEvent>((event, emit) => emit(CategoryState()));


    on<CategoryNameChangedEvent>(
        (event, emit) => emit(state.copyWith(name: event.name)));
    on<DeleteCategoryEvent>((event, emit) => _onDeleteCategory(event, emit));
    on<FormSubmittedEvent>((event, emit) => _onFormSubmitted(event, emit));
    on<FormSubmittedUpdateEvent>(
        (event, emit) => _onFormSubmittedUpdate(event, emit));
    on<EditFormCategoryInitialEvent>(
      (event, emit) => emit(
        state.copyWith(
          name: event.category.name,
          formStatus: const InitialFormStatus(),
        ),
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmittedEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      CategoryDto category = await categoryService.addCategory(
          category: CategoryDto(name: event.name));
      emit(state.copyWith(
          formStatus: FormSubmissionSuccess<CategoryDto>(category)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
    emit(CategoryState());
  }

  void _onFormSubmittedUpdate(
      FormSubmittedUpdateEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      CategoryDto category = await categoryService.editCategory(
          category: CategoryDto(id: event.id, name: event.name));
      emit(state.copyWith(
          formStatus: FormSubmissionSuccess<CategoryDto>(category)));
    } catch (error) {
      emit(state.copyWith(formStatus: FormSubmissionFailed(error.toString())));
    }
  }

  void _onDeleteCategory(DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(deleteStatus: SubmittingDelete()));
    try {
      String message = await categoryService.deleteCategory(id: event.id);
      emit(state.copyWith(
          deleteStatus: SubmissionDeleteSuccess(successMessage: message)));
    } catch (error) {
      emit(state.copyWith(
          deleteStatus:
          SubmissionDeleteFailed(errorMessage: error.toString())));
      emit(state.copyWith(deleteStatus: const InitialDeleteStatus()));
    }
  }

  void _onGetListCategoriesEvent(
      CategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(modelsStatus: Submitting()));
    try {
      List<CategoryDto> categories = await categoryService.getCategories();
      emit(state.copyWith(
          modelsStatus:
              SubmissionSuccess<CategoryDto>(listEntities: categories)));
    } catch (error) {
      emit(state.copyWith(modelsStatus: SubmissionFailed(error)));
    }
  }
}
