import 'package:auto_service/blocs/accountants/accountant_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/accountant_dto.dart';
import 'package:d_chart/d_chart.dart';
import 'package:dartx/dartx.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path/path.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        BlocBuilder<AccountantBloc, AccountantState>(
          builder: (context, state) {
            switch (state.modelsStatus.runtimeType) {
              case Submitting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SubmissionSuccess<AccountantDto>:
                {
                  // Map<DateTime, double> profitMap =
                  // (state.modelsStatus.entities as List<AccountantDto>)
                  //     .map((e) {
                  //   return {e.dateCreated!: e.profit!};
                  // }) as Map<DateTime, double>;
                  // Map<DateTime, double> expenseMap =
                  // (state.modelsStatus.entities as List<AccountantDto>)
                  //     .map((e) {
                  //   return {e.dateCreated!: e.expense!};
                  // }) as Map<DateTime, double>;
                  return chart(state, context);
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
        const Spacer(),
      ],
    );
  }

  Widget chart(AccountantState state, BuildContext context) {



      return SizedBox(
        width: 800,
        height: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () { },
              child: Text('export'),
            ),
          ),
        ),
      );
    }
  }

