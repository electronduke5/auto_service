import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ColorSchemes/color_schemes.g.dart';

class RoleDropDownFilter extends StatefulWidget {
  const RoleDropDownFilter({super.key});

  @override
  State<RoleDropDownFilter> createState() => _RoleDropDownFilterState();
}

class _RoleDropDownFilterState extends State<RoleDropDownFilter> {
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
    return BlocBuilder<GetEmployeesBloc, GetEmployeesState>(
      builder: (context, state) {
        return DropdownButton(
          items: _menuItems,
          icon: const Icon(Icons.filter_list),
          dropdownColor: darkColorScheme.background,
          value: _selectedItem1,
          hint: const Text('Фильтрация'),
          elevation: 4,
          onChanged: (String? value) => setState(
            () {
              _selectedItem1 = value ?? "";
              context.read<GetEmployeesBloc>().add(RoleFilterEvent(value!));
            },
          ),
        );
      },
    );
  }
}
