import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/services/get_employees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'blocs/get_models_status.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = size.height / 2;
    final double itemWidth = size.height * 0.8;
    final loggedEmployee = ModalRoute.of(context)!.settings.arguments as EmployeeDto;

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
                //child: Center(child: Text(user.getFullName())),
                child: Center(child: Text("${loggedEmployee.surname} ${loggedEmployee.name}")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/LoginPage');
                    },
                    icon: const Icon(Icons.logout)),
              ),
            ],
          ),
        ],
      ),
      body: (BlocProvider<GetEmployeesBloc>(
        create: (context) =>
            GetEmployeesBloc(getEmployeesService: GetEmployeesService())
              ..add(GetListEmployeesEvent()),
        child: _buildEmployeesList(context, itemWidth, itemHeight),
      )
          //create: (context) => GetEmployeesBloc(getEmployeesService: GetEmployeesService()),
          //create: (_) => context.read<GetEmployeesBloc>(),
          ),
    );
  }

  Widget _buildEmployeesList(
      BuildContext context, double itemWidth, double itemHeight) {
    return BlocListener<GetEmployeesBloc, GetEmployeesState>(
      listener: (context, state) {
        if (state.modelsStatus is SubmissionFailed) {
          _showShackBar(context, state.modelsStatus.error.toString());
        }
      },
      child: Row(
        children: [
          //Столбец с действиями
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_outline),
                  onPressed: () {},
                  label: const Text(
                    "Мой профиль",
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add_alt),
                  onPressed: () {},
                  label: const Text(
                    "Добавить сотрудника",
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton.icon(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                  label: const Text(
                    "Настройки",
                  ),
                ),
              ],
            ),
          ),
          //Столбец с Dashboard
          Expanded(
            child: Column(
              children: [
                Row(
                  children: const [
                    DropdownButtonExample(),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<GetEmployeesBloc, GetEmployeesState>(
                    builder: (context, state) {
                      if (state.modelsStatus is Submitting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.modelsStatus is SubmissionSuccess) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(10),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return buildEmployeeCard(
                                employee: (state.modelsStatus.entities
                                    as List<EmployeeDto>)[index]);
                          },
                          itemCount:
                              (state.modelsStatus.entities as List<EmployeeDto>)
                                  .length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                        );
                      } else if (state.modelsStatus is SubmissionFailed) {
                        return Center(
                          child: Text(state.modelsStatus.error!),
                        );
                      } else {
                        return const Center(
                          child: Text("Непредвиденная ошибка!"),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildEmployeeCard({required EmployeeDto employee}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.getFullName(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text("Должность: ${employee.role}"),
                Text("ЗП: ${employee.salary} руб."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const menuItems = <String>[
    'По фамилии',
    'По должности',
    'По размеру зарплаты'
  ];

  final List<DropdownMenuItem<String>> _menuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String? _selectedItem1;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton(
      items: _menuItems,
      value: _selectedItem1,
      hint: const Text('Выберите...'),
      elevation: 4,
      onChanged: (String? value) => setState(() {
        _selectedItem1 = value ?? "";
      }),
    );
    return SizedBox(
      width: 350,
      child: ListTile(
        title: const Text('Сортировка:'),
        trailing: dropdown,
      ),
    );
  }
}

void _showShackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Theme.of(context).errorColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
