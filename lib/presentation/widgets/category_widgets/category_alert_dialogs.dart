import 'package:auto_service/blocs/categories/categories_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDialogs {
  static final GlobalKey<FormState> key = GlobalKey<FormState>();

  static Future openDialog({
    required BuildContext context,
    CategoryDto? category,
    required CategoryBloc bloc,
    required StorekeeperNavBloc navBloc,
  }) =>
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is FormSubmissionFailed) {
                SnackBarInfo.show(
                    context: context,
                    message: formStatus.exception.toString(),
                    isSuccess: false);
              } else if (formStatus is FormSubmissionSuccess<CategoryDto>) {
                SnackBarInfo.show(
                    context: context,
                    message: category == null
                        ? 'Категория создана'
                        : 'Категория изменена',
                    isSuccess: true);
              }
            },
            child: AlertDialog(
              title: Text(category == null
                  ? 'Добавление категории'
                  : 'Изменение категории'),
              content: BlocBuilder<CategoryBloc, CategoryState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: key,
                    child: TextFormField(
                      initialValue: category?.name ?? '',
                      validator: (value) {
                        if (value!.length > 30) {
                          return "Число должно быть больше нуля";
                        }
                        return value.isNotEmpty
                            ? null
                            : "Это обязательное поле";
                      },
                      onChanged: (value) {
                        bloc.add(CategoryNameChangedEvent(value));
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'Фильтры',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                        labelText: "Название",
                      ),
                    ),
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return state.formStatus is FormSubmitting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                category == null
                                    ? bloc.add(FormSubmittedEvent(state.name))
                                    : bloc.add(
                                        FormSubmittedUpdateEvent(
                                            category.id!, state.name),
                                      );
                                key.currentState!.reset();
                                bloc.add(GetListCategoriesEvent());
                                navBloc.add(ToViewCategoriesEvent());
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                                category == null ? 'Добавить' : 'Изменить'));
                  },
                )
              ],
            ),
          ),
        ),
      );
}
