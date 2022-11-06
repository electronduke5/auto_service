import 'package:auto_service/ColorSchemes/color_schemes.g.dart';
import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/add_employee_bloc/add_employee_bloc.dart';

/*TODO: Сделать
        1. Отображение circulavatar принажатии накнопку добавления пользователя
        2. Добавить вывод ошибок
        3. Добавить вывод того, что пользователь создался
        4. очищение полей после создания пользователя
        5. Проверить что будет если ошибка
        6. Вроде бы почему то не подсвечивает поля с ошибками

 */

class MainPage extends StatelessWidget {
  final _addEmployeeFormKey = GlobalKey<FormState>();
  final _searchEmployeeFormKey = GlobalKey<FormState>();

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
                  //child: Center(child: Text(user.getFullName())),
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
          _showShackBar(context, state.modelsStatus.error.toString());
        }
      },
      child: Row(
        children: [
          //Столбец с действиями
          Container(
            color: darkColorScheme.surface,
            child: Row(
              children: [
                Padding(
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
                        label: const Text(
                          "Все сотрудники",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.person_outline),
                        onPressed: () {
                          context.read<HrNavigationBloc>().add(
                              ToProfilePage(loggedEmployee: loggedEmployee));
                        },
                        label: const Text(
                          "Мой профиль",
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
                        label: const Text(
                          "Добавить сотрудника",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
              ],
            ),
          ),
          //Столбец с Dashboard
          Expanded(
            child: BlocBuilder<HrNavigationBloc, HrNavigationState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case HrInViewState:
                  return _buildListEmployee(width, height, context);
                case HrInAddState:
                  return _cardAddEmployee(width, context);
                case HrInProfileState:
                  return const Text("Страница профиля сотрудника");
                default:
                  return const Text("Пиздец че");
              }
            }),
          ),
        ],
      ),
    ));
  }

  Widget _cardAddEmployee(double width, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 2),
      child: BlocListener<AddEmployeeBloc, AddEmployeeState>(
        listener: (context, state) {
          switch (state.formStatus.runtimeType) {
            case SubmissionFailed:
              _showShackBar(context,
                  state.formStatus.runtimeType.toString() + ' mainPage 156');
              break;
            case SubmissionSuccess<EmployeeDto>:
              _showShackBar(context, 'Сотрудник успешно доавблен в систему');
              break;
          }
          final formStatus = state.formStatus;
          if (formStatus.runtimeType is SubmissionFailed) {}
        },
        child: BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
          builder: (context, state) {
            return Form(
              key: _addEmployeeFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Добавление сотрудника",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: width / 10),
                      const Text("Личная информация:"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: width / 10),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => state.isValidSurname
                              ? null
                              : "Это обязательное поле",
                          onChanged: (value) => context
                              .read<AddEmployeeBloc>()
                              .add(SurnameChanged(value)),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Фамилия",
                          ),
                        ),
                      ),
                      SizedBox(width: width / 20),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => state.isValidName
                              ? null
                              : "Это обязательное поле",
                          onChanged: (value) => context
                              .read<AddEmployeeBloc>()
                              .add(NameChanged(value)),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Имя",
                          ),
                        ),
                      ),
                      SizedBox(width: width / 20),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) => context
                              .read<AddEmployeeBloc>()
                              .add(PatronymicChanged(value)),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Отчество",
                          ),
                        ),
                      ),
                      SizedBox(width: width / 10),
                    ],
                  ),
                  const Divider(
                    endIndent: 30,
                    indent: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(width: width / 10),
                      const Text("Информация о должности:"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: width / 10),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => state.isValidSalary
                              ? null
                              : "Это обязательное поле",
                          onChanged: (value) => context
                              .read<AddEmployeeBloc>()
                              .add(SalaryChanged(int.parse(value))),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.money),
                            border: OutlineInputBorder(),
                            labelText: "Заработная плата",
                          ),
                        ),
                      ),
                      SizedBox(width: width / 20),
                      const Expanded(
                        child: RoleDropDown(),
                      ),
                      SizedBox(width: width / 10),
                    ],
                  ),
                  const Divider(
                    endIndent: 30,
                    indent: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(width: width / 10),
                      const Text("Информация о профиле:"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: width / 10),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => state.isValidLogin
                              ? null
                              : "Это обязательное поле",
                          onChanged: (value) => context
                              .read<AddEmployeeBloc>()
                              .add(LoginChanged(value)),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.abc),
                            border: OutlineInputBorder(),
                            labelText: "Логин",
                          ),
                        ),
                      ),
                      SizedBox(width: width / 20),
                      Expanded(
                        child: TextFormField(
                          validator: (value) => state.isValidPassword
                              ? null
                              : "Это обязательное поле",
                          onChanged: (value) => context
                              .read<AddEmployeeBloc>()
                              .add(PasswordChanged(value)),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                            labelText: "Пароль",
                          ),
                        ),
                      ),
                      SizedBox(width: width / 10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: width / 2),
                      Expanded(
                        child: BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).focusColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20)),
                              onPressed: () {
                                if (_addEmployeeFormKey.currentState!
                                    .validate()) {
                                  context.read<AddEmployeeBloc>().add(
                                      FormSubmitted(
                                          surname: state.surname,
                                          name: state.name,
                                          patronymic: state.patronymic,
                                          salary: state.salary,
                                          role: state.role,
                                          login: state.login,
                                          password: state.password));
                                }
                              },
                              child: const Text("Добавить"),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: width / 2),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListEmployee(double width, double height, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const DropdownButtonExample(),
            Form(
              key: _searchEmployeeFormKey,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      maxLines: 1,
                      validator: (value) =>
                          value != null ? null : "Это обязательное поле",
                      onChanged: (value) => context
                          .read<GetEmployeesBloc>()
                          .add(SearchChangedEvent(value)),
                      decoration: const InputDecoration(
                        hintText: "Поиск",
                      ),
                    ),
                  ),
                  BlocBuilder<GetEmployeesBloc, GetEmployeesState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (_searchEmployeeFormKey.currentState!.validate()) {
                            context
                                .read<GetEmployeesBloc>()
                                .add(SearchEmployeeEvent(state.searchQuery));
                          }
                        },
                        icon: const Icon(Icons.search),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
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

  GridView _employeeGridView(GetEmployeesState state, double width,
      double height, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return buildEmployeeCard(
            employee: (state.modelsStatus.entities as List<EmployeeDto>)[index],
            context: context);
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

  Widget buildEmployeeCard(
      {required EmployeeDto employee, required BuildContext context}) {
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

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static Map<String, GetEmployeesEvent> menuItemsMap = {
    'По фамилии': SortBySurname(),
    'По должности': SortByRole(),
    'По возростанию ЗП': SortBySalary(),
    'По убыванию ЗП': SortBySalaryDesc()
  };

  final List<DropdownMenuItem<GetEmployeesEvent>> _menuItemsMap = menuItemsMap
      .map((key, value) => MapEntry(
          key,
          DropdownMenuItem<GetEmployeesEvent>(
            value: value,
            child: Text(key),
          )))
      .values
      .toList();

  GetEmployeesEvent? _selectedItem1;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton<GetEmployeesEvent>(
      items: _menuItemsMap,
      value: _selectedItem1,
      hint: const Text('Выберите...'),
      elevation: 4,
      onChanged: (event) => setState(() {
        _selectedItem1 = event ?? _menuItemsMap.first.value;
        context.read<GetEmployeesBloc>().add(_selectedItem1!);
      }),
    );
    return SizedBox(
      width: 350,
      child: BlocBuilder<GetEmployeesBloc, GetEmployeesState>(
        builder: (context, state) {
          return ListTile(
            title: const Text('Сортировка:'),
            trailing: dropdown,
          );
        },
      ),
    );
  }
}

class RoleDropDown extends StatefulWidget {
  const RoleDropDown({super.key});

  @override
  State<RoleDropDown> createState() => _RoleDropDownState();
}

class _RoleDropDownState extends State<RoleDropDown> {
  static const menuItems = <String>[
    'Грузчик',
    'Бухгалтер',
    'HR менеджер',
    'Менеджер по закупкам',
    'Менеджер по работе с клиентами'
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
    return BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
      builder: (context, state) {
        return DropdownButton(
          items: _menuItems,
          icon: const Icon(Icons.work_outline),
          dropdownColor: darkColorScheme.background,
          value: _selectedItem1,
          hint: const Text('Должность'),
          elevation: 4,
          onChanged: (String? value) => setState(() {
            _selectedItem1 = value ?? "";
            context.read<AddEmployeeBloc>().add(RoleChanged(value!));
          }),
          underline: Container(),
        );
      },
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
