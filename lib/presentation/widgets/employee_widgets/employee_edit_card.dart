import 'package:auto_service/blocs/employee_bloc/employee_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmployeeEditCard extends StatelessWidget {
  EmployeeEditCard(
      {Key? key,
      required this.width,
      //required this.formKey,
      required this.navigationState,
      this.employee})
      : super(key: key);

  final double width;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HrNavigationState navigationState;
  final EmployeeDto? employee;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  navigationState is HrInAddState
                      ? "Добавление сотрудника"
                      : "Изменение сотрудника",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                      initialValue: employee?.surname ?? "",
                      validator: (value) =>
                          state.isValidSurname ? null : "Это обязательное поле",
                      onChanged: (value) => context
                          .read<EmployeeBloc>()
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
                      initialValue: employee?.name ?? "",
                      validator: (value) =>
                          state.isValidName ? null : "Это обязательное поле",
                      onChanged: (value) =>
                          context.read<EmployeeBloc>().add(NameChanged(value)),
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
                      initialValue: employee?.patronymic ?? "",
                      onChanged: (value) => context
                          .read<EmployeeBloc>()
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
                      initialValue: employee?.salary.toString() ?? "",
                      validator: (value) {
                        if (int.tryParse(value!) == null) {
                          return 'Поле должно состоять из цифр';
                        } else if (int.parse(value) <= 0) {
                          return "Число должно быть больше нуля";
                        }
                        return value.isNotEmpty
                            ? null
                            : "Это обязательное поле";
                      },
                      onChanged: (value) => context
                          .read<EmployeeBloc>()
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
                  Expanded(
                    child: dropDown(context),
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
                      initialValue: employee?.login ?? "",
                      validator: (value) {
                        if (navigationState is HrInAddState ? !state.isValidAddLogin : !state.isValidLogin(employee?.login)) {
                          return "Это обязательное поле";
                        } else if (!state.isValidLoginLength) {
                          return "Минимальная длина 3 символа";
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          context.read<EmployeeBloc>().add(LoginChanged(value)),
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
                      validator: (value) {
                        if(navigationState is HrInAddState){
                          if (!state.isValidPassword) {
                            return "Это обязательное поле";
                          } else if (!state.isValidPasswordLength) {
                            return "Минимальная длина 8 символа";
                          } else if (!state.isValidPasswordRegex) {
                            return "Должны присутствовать цифры и заглавные символы";
                          }
                        }
                        return null;
                      },
                      onChanged: (value) => context
                          .read<EmployeeBloc>()
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
                    child: BlocBuilder<EmployeeBloc, EmployeeState>(
                      builder: (context, state) {
                        return state.formStatus is FormSubmitting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).focusColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    navigationState is HrInAddState
                                    ? context.read<EmployeeBloc>().add(
                                        FormSubmitted(
                                            surname: state.surname,
                                            name: state.name,
                                            patronymic: state.patronymic,
                                            salary: state.salary,
                                            role: state.role,
                                            login: state.login,
                                            password: state.password))
                                    :  context.read<EmployeeBloc>().add(
                                        FormSubmittedUpdate(
                                            id: employee!.id!,
                                            surname: state.surname,
                                            name: state.name,
                                            patronymic: state.patronymic,
                                            salary: state.salary,
                                            role: state.role,
                                            login: state.login,
                                            password: state.password));

                                    formKey.currentState!.reset();
                                  }
                                },
                                child: Text(
                                  navigationState is HrInAddState
                                      ? "Добавить"
                                      : "Изменить",
                                ),
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
    );
  }

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

  Widget dropDown(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess<EmployeeDto>) {
          //TODO:Не работает очищение DropDown
          // formKey.currentState!.reset();
          _selectedItem1 = null;
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          return DropdownButtonFormField(
              //key: formKey,
              items: _menuItems,
              icon: const Icon(Icons.work_outline),
              dropdownColor: Theme.of(context).colorScheme.background,
              value: employee != null
                  ? _menuItems
                      .where((element) => element.value.toString() == employee!.role).first.value
                  : _selectedItem1,
              hint: const Text('Должность'),
              elevation: 4,
              validator: (value) =>
                  state.isValidRole ? null : "Это обязательное поле",
              onChanged: (String? value) {
                _selectedItem1 = value ?? "";
                context.read<EmployeeBloc>().add(RoleChanged(value!));
              });
        },
      ),
    );
  }
}
