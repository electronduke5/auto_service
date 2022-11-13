import 'package:auto_service/ColorSchemes/color_schemes.g.dart';
import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/employee_widgets/add_employee_card.dart';
import 'package:auto_service/presentation/widgets/employee_widgets/employee_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 2.5;
    final loggedEmployee =
        ModalRoute.of(context)!.settings.arguments as EmployeeDto;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: SvgPicture.asset(
            "assets/svg/logo.svg",
            color: Theme.of(context).hintColor,
          ),
          titleSpacing: 12,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          "${loggedEmployee.surname} ${loggedEmployee.name}")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/LoginPage');
                      },
                      icon: const Icon(Icons.logout)),
                ),
              ],
            ),
          ],
        ),
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
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.group_outlined),
                    onPressed: () {
                      context
                          .read<HrNavigationBloc>()
                          .add(ToEmployeesPage());
                      context
                          .read<GetEmployeesBloc>()
                          .add(GetListEmployeesEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 7
                    ),
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
                      context
                          .read<HrNavigationBloc>()
                          .add(ToAddEmployeePage());
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 7
                    ),
                    label: const Text(
                      "Добавить сотрудника",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
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
