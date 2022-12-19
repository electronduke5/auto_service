import 'package:auto_service/blocs/accountants/accountant_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/accountant_dto.dart';
import 'package:auto_service/presentation/widgets/accountant_widgets/indicator_widget.dart';
import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AccountantBloc, AccountantState>(
        builder: (context, state) {
          switch (state.modelsStatus.runtimeType) {
            case Submitting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SubmissionSuccess<AccountantDto>:
              {
                List<ListProfit> profitList =
                    (state.modelsStatus.entities as List<AccountantDto>)
                        .map((e) {
                  if (e.profit != 0.0) {
                    return ListProfit(e.dateCreated!, e.profit!);
                  }
                  return ListProfit(null, null);
                }).toList();

                List<ListProfit> expenseList =
                    (state.modelsStatus.entities as List<AccountantDto>)
                        .map((e) {
                  if (e.expense != 0.0) {
                    return ListProfit(e.dateCreated!, e.expense!);
                  }
                  return ListProfit(null, null);
                }).toList();
                profitList.removeWhere((element) => element.profit == null);
                expenseList.removeWhere((element) => element.profit == null);
                var listProfits = getListAccountant(profitList);
                var listExpenses = getListAccountant(expenseList);
                return chart(state, context, listProfits, listExpenses);
              }
            case SubmissionFailed:
              return Center(
                child: Text(state.modelsStatus.error ?? 'Submission Failed'),
              );
            default:
              return const Center(
                child: Text("Непредвиденная ошибка"),
              );
          }
        },
      ),
    );
  }

  Widget chart(
    AccountantState state,
    BuildContext context,
    List<ListAccountant> profitMap,
    List<ListAccountant> expenseList,
  ) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Text('Информация о расходах и доходах',
              style: Theme.of(context).textTheme.headline5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SizedBox(
                width: 500,
                child: Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: 4,
                            borderData: FlBorderData(show: true),
                            sectionsSpace: 2,
                            sections: [
                              PieChartSectionData(
                                  value: expenseList.map((e) => e.money).fold(
                                      0,
                                      (a, b) =>
                                          double.parse(a!.toString()) + b),
                                  color: Colors.red,
                                  radius: 100),
                              PieChartSectionData(
                                  value: profitMap.map((e) => e.money).fold(
                                      0,
                                      (a, b) =>
                                          double.parse(a!.toString()) + b),
                                  color: Colors.green,
                                  radius: 100),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Colors.green,
                            text: 'Доходы',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.red,
                            text: 'Расходы',
                            isSquare: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 700,
              height: 300,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      minX: 1,
                      maxX: 12,
                      maxY: 600000,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                            isCurved: true,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.greenAccent.withOpacity(0.4),
                            ),
                            color: Colors.green,
                            spots: profitMap
                                .map((e) => FlSpot(e.month.toDouble(), e.money))
                                .toList()),
                        LineChartBarData(
                            isCurved: true,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.redAccent.withOpacity(0.4),
                            ),
                            color: Colors.red,
                            spots: expenseList
                                .map((e) => FlSpot(e.month.toDouble(), e.money))
                                .toList()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.floor()) {
            case 1:
              text = 'Янв';
              break;
            case 2:
              text = 'Фев';
              break;
            case 3:
              text = 'Мар';
              break;
            case 4:
              text = 'Апр';
              break;
            case 5:
              text = 'Май';
              break;
            case 6:
              text = 'Июнь';
              break;
            case 7:
              text = 'Июль';
              break;
            case 8:
              text = 'Авг';
              break;
            case 9:
              text = 'Сен';
              break;
            case 10:
              text = 'Окт';
              break;
            case 11:
              text = 'Ноя';
              break;
            case 12:
              text = 'Дек';
              break;
          }

          return Text(text);
        },
      );
}

List<ListAccountant> getListAccountant(List<ListProfit> list) {
  var newList = list.groupBy((element) => element.date!.month);
  List<ListAccountant> resultList = <ListAccountant>[];

  var values = newList.values.map((e) => e.map((e) => e.profit).fold(
      0,
      (previousValue, element) =>
          double.parse(previousValue!.toString()) + element!));
  for (int i = 0; i < newList.length; i++) {
    resultList.add(ListAccountant(
        newList.keys.elementAt(i), values.elementAt(i).toDouble()));
  }
  return resultList;
}

class ListProfit {
  final DateTime? date;
  final double? profit;

  ListProfit(this.date, this.profit);
}

class ListAccountant {
  final int month;
  final double money;

  ListAccountant(this.month, this.money);
}
