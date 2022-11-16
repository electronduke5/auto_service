import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:auto_service/presentation/widgets/employee_widgets/add_employee_card.dart';
import 'package:auto_service/presentation/widgets/employee_widgets/employee_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  List<Widget> widgets(BuildContext context) => [
        ElevatedButton.icon(
          icon: const Icon(Icons.group_outlined),
          onPressed: () {
            context.read<HrNavigationBloc>().add(ToEmployeesPage());
            context.read<GetEmployeesBloc>().add(GetListEmployeesEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Все сотрудники",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.person_add_alt),
          onPressed: () {
            context.read<HrNavigationBloc>().add(ToAddEmployeePage());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Добавить сотрудника",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 2.5;
    final EmployeeDto loggedEmployee =
        ModalRoute.of(context)!.settings.arguments as EmployeeDto;

    return Scaffold(
        appBar: AppBarWidget(loggedEmployee: loggedEmployee, context: context),
        body: _buildMainPage(context, cardHeight, cardWidth, loggedEmployee));
  }

  Widget _buildMainPage(BuildContext context, double height, double width,
      EmployeeDto loggedEmployee) {
    return (BlocListener<GetEmployeesBloc, GetEmployeesState>(
      listener: (context, state) {
        if (state.modelsStatus is SubmissionFailed) {
          SnackBarInfo.show(
              context: context,
              message: state.modelsStatus.error.toString(),
              isSuccess: false);
        }
      },
      child: Row(
        children: [
          //Столбец с действиями
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
            child: MainActionsCard(children: [...widgets(context)]),
          ),
          //Столбец с Dashboard
          Expanded(
            child: BlocBuilder<HrNavigationBloc, HrNavigationState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case HrInViewState:
                    return EmployeeCard(width: width, height: height);
                  case HrInAddState:
                    return AddEmployeeCard(
                        width: width, navigationState: state);
                  case HrInEditState:
                    return AddEmployeeCard(
                        width: width,
                        navigationState: state,
                        employee: state.employeeEdit);
                  case HrInProfileState:
                    return const Text("Страница профиля сотрудника");
                  default:
                    return const Text("Пиздец че");
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
