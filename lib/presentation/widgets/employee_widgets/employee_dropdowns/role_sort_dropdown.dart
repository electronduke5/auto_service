import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleDropDownSorting extends StatefulWidget {
  const RoleDropDownSorting({super.key});

  @override
  State<RoleDropDownSorting> createState() => _RoleDropDownSortingState();
}

class _RoleDropDownSortingState extends State<RoleDropDownSorting> {
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
