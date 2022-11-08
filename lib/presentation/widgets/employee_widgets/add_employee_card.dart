import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ColorSchemes/color_schemes.dart';
import '../../../blocs/add_employee_bloc/add_employee_bloc.dart';
import '../../../blocs/form_submission_status.dart';
import '../../../data/dto/employee_dto.dart';

class AddEmployeeCard extends StatelessWidget {
  AddEmployeeCard({Key? key, this.width}) : super(key: key);
  final width;
  final addEmployeeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 2),
      child: BlocListener<AddEmployeeBloc, AddEmployeeState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormSubmissionFailed) {
            SnackBarInfo.show(
                context: context,
                message: formStatus.exception.toString(),
                isSuccess: false);
          } else if (formStatus is FormSubmissionSuccess<EmployeeDto>) {
            SnackBarInfo.show(
                context: context,
                message: 'Сотрудник успешно доавблен в систему',
                isSuccess: true);
          }
        },
        child: _addEmployeeCard(),
      ),
    );
  }

  BlocBuilder<AddEmployeeBloc, AddEmployeeState> _addEmployeeCard() {
    return BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
      builder: (context, state) {
        return Form(
          key: addEmployeeFormKey,
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
                      validator: (value) =>
                          state.isValidSurname ? null : "Это обязательное поле",
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
                      validator: (value) =>
                          state.isValidName ? null : "Это обязательное поле",
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
                      validator: (value) {
                        if (!state.isValidLogin) {
                          return "Это обязательное поле";
                        } else if (!state.isValidLoginLength) {
                          return "Минимальная длина 3 символа";
                        }
                      },
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
                      validator: (value) {
                        if (!state.isValidPassword) {
                          return "Это обязательное поле";
                        } else if (!state.isValidPasswordLength) {
                          return "Минимальная длина 8 символа";
                        } else if (!state.isValidPasswordRegex) {
                          return "Должны присутствовать цифры и заглавные символы";
                        }
                      },
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
                                  if (addEmployeeFormKey.currentState!
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

                                    addEmployeeFormKey.currentState!.reset();
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
    );
  }
}

class RoleDropDown extends StatefulWidget {
  const RoleDropDown({super.key});

  @override
  State<RoleDropDown> createState() => _RoleDropDownState();
}

class _RoleDropDownState extends State<RoleDropDown> {
  final _addEmployeeFormKey = GlobalKey<FormState>();

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
    return BlocListener<AddEmployeeBloc, AddEmployeeState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess<EmployeeDto>) {
          //TODO:Не работает очищение DropDown
          _addEmployeeFormKey.currentState!.reset();
          _selectedItem1 = null;
        }
      },
      child: BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
        builder: (context, state) {
          return DropdownButtonFormField(
            key: _addEmployeeFormKey,
            items: _menuItems,
            icon: const Icon(Icons.work_outline),
            dropdownColor: darkColorScheme.background,
            value: _selectedItem1,
            hint: const Text('Должность'),
            elevation: 4,
            validator: (value) =>
                state.isValidRole ? null : "Это обязательное поле",
            onChanged: (String? value) => setState(() {
              _selectedItem1 = value ?? "";
              context.read<AddEmployeeBloc>().add(RoleChanged(value!));
            }),
          );
        },
      ),
    );
  }
}
