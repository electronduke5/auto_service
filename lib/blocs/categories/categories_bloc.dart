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
