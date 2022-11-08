import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/employee_widgets/employee_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employee_dropdowns/role_filter_dropdown.dart';
import 'employee_dropdowns/role_sort_dropdown.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            children: [
              const RoleDropDownSorting(),
              const SizedBox(width: 40),
              EmployeeSearchField(),
              const SizedBox(width: 40),
              const RoleDropDownFilter()
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<GetEmployeesBloc, GetEmployeesState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<EmployeeDto>:
                  return _employeeGridView(state, width, height, context);

                case SubmissionFailed:
                  {
                    return Center(
                      child: Text(state.modelsStatus.error!),
                    );
                  }
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

  Widget _employeeGridView(GetEmployeesState state, double width, double height,
      BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return _employeeViewCard(
            context: context,
            employee:
                (state.modelsStatus.entities as List<EmployeeDto>)[index]);
      },
      itemCount: (state.modelsStatus.entities as List<EmployeeDto>).length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 10,
        //mainAxisExtent: 160,
        childAspectRatio: width / height,
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }

  Padding _employeeViewCard(
      {required BuildContext context, required EmployeeDto employee}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.getFullName(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Должность: ${employee.role}",
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  Text(
                    "ЗП: ${employee.salary} руб.",
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
