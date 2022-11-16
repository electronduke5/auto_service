import 'package:auto_service/blocs/get_employees_bloc/get_employees_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/presentation/widgets/employee_widgets/employee_edit_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../blocs/form_submission_status.dart';
import '../../../data/dto/employee_dto.dart';

class AddEmployeeCard extends StatelessWidget {
  AddEmployeeCard(
      {Key? key, this.width, required this.navigationState, this.employee})
      : super(key: key);
  final width;
  final addEmployeeFormKey = GlobalKey<FormState>();
  final editEmployeeFormKey = GlobalKey<FormState>();
  final HrNavigationState navigationState;
  final EmployeeDto? employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 2),
      child: BlocListener<EmployeeBloc, EmployeeState>(
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
                message: navigationState is HrInAddState
                    ? 'Сотрудник успешно доавблен в систему'
                    : 'Данные сотрудника обновлены',
                isSuccess: true);
            context.read<HrNavigationBloc>().add(ToEmployeesPage());
            context.read<GetEmployeesBloc>().add(GetListEmployeesEvent());
          }
        },
        child: addEmployeeCard(),
      ),
    );
  }

  Widget addEmployeeCard() {
    return EmployeeEditCard(
      navigationState: navigationState,
      employee: employee,
      width: width,
    );
  }
}
