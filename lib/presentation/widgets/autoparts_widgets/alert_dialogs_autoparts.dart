import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartsDialog {
  static Future openDeleteDialog(
          BuildContext context, AutopartDto autopart, AutopartBloc bloc) =>
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: AlertDialog(
            title: const Text('Подтверждение удаления'),
            content: Text(
                'Вы действительно хотите удалить все ${autopart.count} запчасти?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Отменить'),
                ),
              ),
              BlocBuilder<AutopartBloc, AutopartState>(
                bloc: bloc,
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).errorColor,
                    ),
                    onPressed: () {
                      bloc.add(DeleteAutopartEvent(autopart.id!));
                      SnackBarInfo.show(
                          context: context,
                          message: 'Запчасти ${autopart.name} удалены!',
                          isSuccess: true);
                      bloc.add(GetListAutopartsEvent());
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Удалить'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
  static final GlobalKey<FormState> editCountKey = GlobalKey<FormState>();

  static Future openEditDialog(
          BuildContext context, AutopartDto autopart, AutopartBloc bloc) =>
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: BlocListener<AutopartBloc, AutopartState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is FormSubmissionFailed) {
                SnackBarInfo.show(
                    context: context,
                    message: formStatus.exception.toString(),
                    isSuccess: false);
              } else if (formStatus is FormSubmissionSuccess<AutopartDto>) {
                SnackBarInfo.show(
                    context: context,
                    message: 'Запчасти успешно заказаны',
                    isSuccess: true);
              }
            },
            child: AlertDialog(
              title: const Text('Дозаказ запчасти'),
              content: BlocBuilder<AutopartBloc, AutopartState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: editCountKey,
                    child: TextFormField(
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Поле должно состоять из цифр';
                        } else if (int.parse(value) <= 0) {
                          return "Число должно быть больше нуля";
                        }
                        return value.isNotEmpty
                            ? null
                            : "Это обязательное поле";
                      },
                      onChanged: (value) {
                        bloc.add(CountChanged(value));
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.onetwothree),
                        border: OutlineInputBorder(),
                        labelText: "Количество",
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
                BlocBuilder<AutopartBloc, AutopartState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () {
                          if (editCountKey.currentState!.validate()) {
                            bloc.add(
                              FormSubmittedUpdate(
                                  id: autopart.id!,
                                  count: int.parse(state.count),
                                  autopart: autopart),
                            );
                            editCountKey.currentState!.reset();
                            bloc.add(GetListAutopartsEvent());
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Заказать'));
                  },
                )
              ],
            ),
          ),
        ),
      );
}
