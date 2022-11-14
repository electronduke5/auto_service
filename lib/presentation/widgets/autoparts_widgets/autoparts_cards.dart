import 'package:auto_service/blocs/autoparts/view_autoparts/view_autoparts_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartsCards extends StatelessWidget {
  AutopartsCards({Key? key}) : super(key: key);

  final Map<dynamic, Color> countColor = {
    IntRange(0, 5): const Color(0xFFEA3D2F),
    IntRange(6, 11): const Color(0xFFF3AA18),
    IntRange(12, 18): const Color(0xFF2FA84F),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ViewAutopartsBloc, ViewAutopartsState>(
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

  Widget _autopartsListView(ViewAutopartsState state, BuildContext context) {
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
                    color: countColor.entries.firstWhere((element) => element.key.contains(autopart.count)).value),
                const VerticalDivider(),
                _itemInRow(value: autopart.category!.name.toString()),
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

  Widget _tableHeaderElement(String value) {
    return Expanded(
      child: Center(
        child: Text(value),
      ),
    );
  }
}
