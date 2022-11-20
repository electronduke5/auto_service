import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartSortDropDown extends StatefulWidget {
  const AutopartSortDropDown({super.key});

  @override
  State<AutopartSortDropDown> createState() => _AutopartSortDropDownState();
}

class _AutopartSortDropDownState extends State<AutopartSortDropDown> {
  static Map<String, AutopartEvent> menuItemsMap = {
    'По названию': SortByAutopartEvent(sortByQuery: 'name'),
    'По возрастанию закупочной цены':
        SortByAutopartEvent(sortByQuery: 'purchase_price'),
    'По возрастанию продажной цены':
        SortByAutopartEvent(sortByQuery: 'sale_price'),
    'По возрастанию колчичества': SortByAutopartEvent(sortByQuery: 'count'),
    'По убыванию закупочной цены':
        SortByDescAutopartEvent(sortByDescQuery: 'purchase_price'),
    'По убыванию продажной цены':
        SortByDescAutopartEvent(sortByDescQuery: 'sale_price'),
    'По убыванию колчичества':
        SortByDescAutopartEvent(sortByDescQuery: 'count'),
  };

  final List<DropdownMenuItem<AutopartEvent>> _menuItemsMap = menuItemsMap
      .map((key, value) => MapEntry(
          key,
          DropdownMenuItem<AutopartEvent>(
            value: value,
            child: Text(key),
          )))
      .values
      .toList();
  AutopartEvent? _selectedItem;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton<AutopartEvent>(
      items: _menuItemsMap,
      value: _selectedItem,
      hint: const Text('Выберите...'),
      elevation: 4,
      onChanged: (event) => setState(() {
        _selectedItem = event ?? _menuItemsMap.first.value;
        context.read<AutopartBloc>().add(_selectedItem!);
      }),
    );
    return SizedBox(
      width: 450,
      child: BlocBuilder<AutopartBloc, AutopartState>(
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
