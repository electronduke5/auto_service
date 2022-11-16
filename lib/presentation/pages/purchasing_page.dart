import 'package:auto_service/blocs/autoparts/view_autoparts/view_autoparts_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/purchasing_nav_bloc/purchasing_nav_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/autoparts_cards.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchasingPage extends StatelessWidget {
  const PurchasingPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final loggedEmployee =
        ModalRoute.of(context)!.settings.arguments as EmployeeDto;

    return Scaffold(
      appBar: AppBarWidget(context: context, loggedEmployee: loggedEmployee),
      body: _buildPurchaseBody(context),
    );
  }

  Widget _buildPurchaseBody(BuildContext context) {
    return BlocListener<ViewAutopartsBloc, ViewAutopartsState>(
      listener: (context, state) {
        if (state.modelsStatus is SubmissionFailed) {
          SnackBarInfo.show(
              context: context,
              message: state.modelsStatus.error.toString(),
              isSuccess: false);
        }
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
            child: MainActionsCard(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.list_alt_outlined),
                  onPressed: () {
                    context.read<PurchasingNavBloc>().add(ToViewAutopartsPageEvent());
                    context.read<ViewAutopartsBloc>().add(GetListAutopartsEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "Все запчасти",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_box_outlined),
                  onPressed: () {
                    context.read<PurchasingNavBloc>().add(ToAddAutopartPageEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "Заказ запчасти",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

           Expanded(
              child: AutopartsCards()
          ),
        ],
      ),
    );
  }
}
