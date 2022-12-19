import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/categories/categories_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/alert_dialogs_autoparts.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/autopart_search_field.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/autopart_sort_dropdown.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartsCards extends StatelessWidget {
  AutopartsCards(
      {Key? key, required this.context, required this.loggedEmployee})
      : super(key: key);
  BuildContext context;
  final EmployeeDto loggedEmployee;

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
          child: Row(
            children: [
              const AutopartSortDropDown(),
              AutopartSearchField(),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
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
                        child: CircularProgressIndicator(),
                      );
                  }
                }),
              ),
            ],
          ),
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
                _itemInRow(value: autopart.category?.name.toString()),
                const VerticalDivider(),
                Expanded(
                  child: loggedEmployee.role == RoleEnum.purchasing.name
                      ? Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            onPressed: () {
                              AutopartsDialog.openEditDialog(context, autopart,
                                  context.read<AutopartBloc>());
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text('Заказать'),
                            ),
                          ),
                        )
                      : Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BlocBuilder<StorekeeperNavBloc,
                                  StorekeeperNavState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withOpacity(0.8),
                                    ),
                                    onPressed: () {
                                      context.read<AutopartBloc>().add(
                                          EditFormInitial(autopart: autopart));
                                      context
                                          .read<CategoryBloc>()
                                          .add(GetListCategoriesEvent());
                                      context
                                          .read<StorekeeperNavBloc>()
                                          .add(ToEditAutopartEvent(autopart));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('Изменить'),
                                    ),
                                  );
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                ),
                                onPressed: () {
                                  AutopartsDialog.openDeleteDialog(context,
                                      autopart, context.read<AutopartBloc>());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(Icons.delete_outline),
                                ),
                              ),
                            ],
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

  Widget _itemInRow({required String? value, Color? color}) {
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
                  child: Text(value?? ''),
                ),
              )
            : Text(value?? ''),
      ),
    );
  }

  Widget _tableHeaderElement(String value) {
    return Expanded(
      child: Center(
        child: Text(value),
      ),
    );
  }
}
