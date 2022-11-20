import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartSearchField extends StatelessWidget {
  AutopartSearchField({Key? key}) : super(key: key);
  final _searchFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _searchFormKey,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: TextFormField(
              maxLines: 1,
              validator: (value) =>
                  value != null ? null : "Это обязательное поле",
              onChanged: (value) =>
                  context.read<AutopartBloc>().add(SearchChangedEvent(value)),
              decoration: const InputDecoration(
                hintText: "Поиск",
              ),
            ),
          ),
          BlocBuilder<AutopartBloc, AutopartState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (_searchFormKey.currentState!.validate()) {
                    context.read<AutopartBloc>().add(
                        SearchAutopartEvent(searchQuery: state.searchQuery));
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
