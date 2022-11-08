import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeSearchField extends StatelessWidget {
  EmployeeSearchField({Key? key}) : super(key: key);
  final _searchEmployeeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
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
    );
  }
}
