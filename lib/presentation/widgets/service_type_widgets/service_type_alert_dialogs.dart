import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/blocs/service_type_bloc/type_bloc.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeDialogs {
  static final GlobalKey<FormState> key = GlobalKey<FormState>();

  static Future openDialog({
    required BuildContext context,
    ServiceTypeDto? type,
    required TypeBloc bloc,
    required StorekeeperNavBloc navBloc,
  }) =>
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: BlocListener<TypeBloc, TypeState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is FormSubmissionFailed) {
                SnackBarInfo.show(
                    context: context,
                    message: formStatus.exception.toString(),
                    isSuccess: false);
              } else if (formStatus is FormSubmissionSuccess<ServiceTypeDto>) {
                SnackBarInfo.show(
                    context: context,
                    message: type == null
                        ? 'Категория создана'
                        : 'Категория изменена',
                    isSuccess: true);
              }
            },
            child: AlertDialog(
              title: Text(type == null
                  ? 'Добавление категории работ'
                  : 'Изменение категории работ'),
              content: BlocBuilder<TypeBloc, TypeState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: key,
                    child: TextFormField(
                      initialValue: type?.name ?? '',
                      validator: (value) {
                        if (value!.length > 30) {
                          return "Слишком длинное название!";
                        }
                        return value.isNotEmpty
                            ? null
                            : "Это обязательное поле";
                      },
                      onChanged: (value) {
                        bloc.add(TypeNameChangedEvent(value));
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.car_repair_rounded),
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
                BlocBuilder<TypeBloc, TypeState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return state.formStatus is FormSubmitting
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : TextButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            type == null
                                ? bloc.add(FormSubmittedEvent(state.name))
                                : bloc.add(
                              FormSubmittedUpdateEvent(
                                  type.id!, state.name),
                            );
                            key.currentState!.reset();
                            bloc.add(GetListTypesEvent());
                            navBloc.add(ToViewTypesEvent());
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                            type == null ? 'Добавить' : 'Изменить'));
                  },
                )
              ],
            ),
          ),
        ),
      );
}
