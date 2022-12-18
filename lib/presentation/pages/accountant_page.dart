import 'dart:io';

import 'package:auto_service/blocs/accountants/accountant_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/accountant_nav_bloc/accountant_nav_bloc.dart';
import 'package:auto_service/data/dto/accountant_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/accountant_widgets/accountant_cards.dart';
import 'package:auto_service/presentation/widgets/accountant_widgets/chart_page.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class AccountantPage extends StatelessWidget {
  const AccountantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 2.5;
    final loggedEmployee =
        ModalRoute.of(context)!.settings.arguments as EmployeeDto;
    return Scaffold(
      appBar: AppBarWidget(context: context, loggedEmployee: loggedEmployee),
      body:
          _buildAccountantBody(context, cardWidth, cardHeight, loggedEmployee),
    );
  }

  List<Widget> widgets(BuildContext context) => [
        ElevatedButton.icon(
          icon: const Icon(Icons.list_alt),
          onPressed: () {
            context.read<AccountantNavBloc>().add(ToViewAllEvent());
            context.read<AccountantBloc>().add(GetAllListEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Все расходы и доходы",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.bar_chart),
          onPressed: () {
            context.read<AccountantNavBloc>().add(ToViewChartEvent());
            context.read<AccountantBloc>().add(GetAllListEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Графики",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.file_copy_outlined),
          onPressed: () {
            createFile(context.read<AccountantBloc>().state);
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Экспорт",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ];

  void createFile(AccountantState state) async {
    var excel = Excel.createExcel();
    String date = DateFormat('dd.MM.yyyy').format(DateTime.now());
    Sheet sheet = excel['Отчет за $date'];

    List<DateTime> dateList =
        (state.modelsStatus.entities as List<AccountantDto>)
            .map((e) => e.dateCreated!)
            .toList();
    List<String> profitList =
        (state.modelsStatus.entities as List<AccountantDto>)
            .map((e) => e.profit.toString())
            .toList();
    List<String> expenseList =
        (state.modelsStatus.entities as List<AccountantDto>)
            .map((e) => e.expense.toString())
            .toList();

    List<String> listTitle = ['Дата', 'Доход', 'Расход'];
    sheet.insertRowIterables(listTitle, 0);

    for (int i = 1; i < dateList.length + 1; i++) {
      var cell =
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i));
      cell.value = DateFormat('dd.MM.yyyy').format(dateList[i - 1]);

      var cellProfit =
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i));
      cellProfit.value = profitList[i - 1];

      var cellExpense =
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i));
      cellExpense.value = expenseList[i - 1];
    }
    List<int>? fileBytes = excel.save();
    //print('saving executed in ${stopwatch.elapsed}');
    String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Выберите файл:',
        type: FileType.custom,
        allowedExtensions: ['xlsx']);
    if (outputFile != null) {
      if (fileBytes != null) {
        File(join(outputFile))
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
      }
    }
  }

  Widget _buildAccountantBody(BuildContext context, double cardWidth,
      double cardHeight, EmployeeDto loggedEmployee) {
    return Row(
      children: [
        //Столбец с действиями
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
          child: MainActionsCard(children: [...widgets(context)]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: BlocBuilder<AccountantNavBloc, AccountantNavState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case AccountantInViewAllState:
                    return AccountantCards(
                        width: cardWidth, height: cardHeight);
                  case AccountantInViewChartState:
                    return ChartPage();
                  default:
                    return const Center(
                      child: Text('Что-то не работает'),
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
