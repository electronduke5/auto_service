import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/purchasing_nav_bloc/purchasing_nav_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:auto_service/services/autoparts_service.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartsCards extends StatelessWidget {
  AutopartsCards({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  GlobalKey<FormState> editCountKey = GlobalKey<FormState>();

  final Map<dynamic, Color> countColor = {
    IntRange(0, 5): const Color(0xFFEA3D2F),
    IntRange(6, 11): const Color(0xFFF3AA18),
    IntRange(12, double.maxFinite.toInt()): const Color(0xFF2FA84F),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Сортировка'),
                  Text('Поиск'),
                  Text('Фильтрация'),
                ],
              ),
              Card(
                elevation: 5,
                color: Theme.of(context).colorScheme.onPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _tableHeaderElement('Название'),
                        const VerticalDivider(),
                        _tableHeaderElement('Закупочная цена'),
                        const VerticalDivider(),
                        _tableHeaderElement('Цена'),
                        const VerticalDivider(),
                        _tableHeaderElement('Кол-во'),
                        const VerticalDivider(),
                        _tableHeaderElement('Категория'),
                        const VerticalDivider(),
                        _tableHeaderElement('Действие'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<AutopartBloc, AutopartState>(
              builder: (context, state) {
            switch (state.modelsStatus.runtimeType) {
              case Submitting:
                return const Center(child: CircularProgressIndicator());

              case SubmissionSuccess<AutopartDto>:
                return _autopartsListView(state, context);

              case SubmissionFailed:
                return Center(
                  child: Text(state.modelsStatus.error ?? "хз"),
                );
              default:
                return const Center(
                  child: Text("Непредвиденная ошибка"),
                );
            }
          }),
        ),
      ],
    );
  }

  Widget _autopartsListView(AutopartState state, BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _autopartCard(
            context: context,
            autopart:
                (state.modelsStatus.entities as List<AutopartDto>)[index]);
      },
      itemCount: (state.modelsStatus.entities as List<AutopartDto>).length,
    );
  }

  Widget _autopartCard(
      {required AutopartDto autopart, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _itemInRow(value: autopart.name.toString()),
                const VerticalDivider(),
                _itemInRow(value: autopart.purchasePrice.toString()),
                const VerticalDivider(),
                _itemInRow(value: autopart.salePrice.toString()),
                const VerticalDivider(),
                _itemInRow(
                    value: autopart.count.toString(),
                    color: countColor.entries
                        .firstWhere(
                            (element) => element.key.contains(autopart.count))
                        .value),
                const VerticalDivider(),
                _itemInRow(value: autopart.category!.name.toString()),
                const VerticalDivider(),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        openDialog(this.context, autopart);
                        //TODO: Событие в AutopartBloc на редактирование данной запчасти (Autopart autopart)
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Заказать'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemInRow({required String value, Color? color}) {
    return Expanded(
      child: Center(
        child: color != null
            ? Card(
                color: color,
                elevation: 0,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 2.0),
                  child: Text(value),
                ),
              )
            : Text(value),
      ),
    );
  }

  Future openDialog(BuildContext context, AutopartDto autopart) => showDialog(
        context: context,
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AutopartBloc>(
              create: (context) =>
                  AutopartBloc(autopartService: AutopartService()),
            ),
            BlocProvider<PurchasingNavBloc>(
              create: (context) => PurchasingNavBloc(),
            ),
          ],
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
                print('грузится?');
                context.read<AutopartBloc>().add(GetListAutopartsEvent());
              }
            },
            child: AlertDialog(
              title: const Text('Дозаказ запчасти'),
              content: BlocBuilder<AutopartBloc, AutopartState>(
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
                        context.read<AutopartBloc>().add(CountChanged(value));
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
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () {
                          if (editCountKey.currentState!.validate()) {
                            context.read<AutopartBloc>().add(
                                  FormSubmittedUpdate(
                                      id: autopart.id!,
                                      count: int.parse(state.count),
                                      autopart: autopart),
                                );
                            editCountKey.currentState!.reset();
                            context.read<AutopartBloc>().add(GetListAutopartsEvent());
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

  Widget _tableHeaderElement(String value) {
    return Expanded(
      child: Center(
        child: Text(value),
      ),
    );
  }
}
