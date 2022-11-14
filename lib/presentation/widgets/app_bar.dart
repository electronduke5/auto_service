import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends AppBar {

  final BuildContext context;
  final EmployeeDto loggedEmployee;

  AppBarWidget( {super.key, required this.context, required this.loggedEmployee}) : super(
    elevation: 10.0,
    backgroundColor: Theme.of(context).colorScheme.tertiary,
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
  );
}
