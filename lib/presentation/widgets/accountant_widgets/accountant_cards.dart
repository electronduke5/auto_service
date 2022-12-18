import 'package:auto_service/blocs/accountants/accountant_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/accountant_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AccountantCards extends StatelessWidget {
  const AccountantCards({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  _tableHeaderElement('Дата', 1),
                  const VerticalDivider(),
                  _tableHeaderElement('Прибыль', 1),
                  const VerticalDivider(),
                  _tableHeaderElement('Убыток', 1),
                  const VerticalDivider(),
                  _tableHeaderElement('Описание', 3),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<AccountantBloc, AccountantState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SubmissionSuccess<AccountantDto>:
                  return _accountantListView(state, width, height, context);
                case SubmissionFailed:
                  return Center(
                    child:
                        Text(state.modelsStatus.error ?? 'Submission Failed'),
                  );
                default:
                  return const Center(
                    child: Text("Непредвиденная ошибка"),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _accountantListView(AccountantState state, double width, double height,
      BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _accountingCard(
          context: context,
          accountant:
              (state.modelsStatus.entities as List<AccountantDto>)[index],
        );
      },
      itemCount: (state.modelsStatus.entities as List<AccountantDto>).length,
    );
  }

  Widget _accountingCard(
      {required BuildContext context, required AccountantDto accountant}) {
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
                _itemInRow(
                    flex: 1,
                    value: DateFormat('dd.MM.yyyy')
                        .format(accountant.dateCreated!)),
                const VerticalDivider(),
                _itemInRow(
                    flex: 1,
                    value: accountant.profit.toString(),
                    color: accountant.profit.toString() != '0.0'
                        ? const Color(0xFF2FA84F)
                        : null),
                const VerticalDivider(),
                _itemInRow(
                    flex: 1,
                    value: accountant.expense.toString(),
                    color: accountant.expense.toString() != '0.0'
                        ? const Color(0xFFEA3D2F)
                        : null),
                const VerticalDivider(),
                _itemInRow(value: accountant.description.toString(), flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemInRow({required String value, Color? color, required int flex}) {
    return Expanded(
      flex: flex,
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

  Widget _tableHeaderElement(String value, int flex) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(value),
      ),
    );
  }
}
