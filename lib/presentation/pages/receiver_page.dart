import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:auto_service/presentation/widgets/client_widgets/client_cards.dart';
import 'package:auto_service/presentation/widgets/client_widgets/client_info_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiverPage extends StatelessWidget {
  const ReceiverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 2.5;
    final loggedEmployee =
    ModalRoute.of(context)!.settings.arguments as EmployeeDto;

    return Scaffold(
      appBar: AppBarWidget(context: context, loggedEmployee: loggedEmployee),
      body: _buildReceiverBody(context, cardWidth, cardHeight, loggedEmployee),
    );
  }

  Widget _buildReceiverBody(
      BuildContext context, double cardWidth, double cardHeight, EmployeeDto loggedEmployee) {
    return BlocListener<ClientBloc, ClientState>(
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
                  icon: const Icon(Icons.group_outlined),
                  onPressed: () {
                    context
                        .read<ReceiverNavBloc>()
                        .add(ToViewClientsEvent());
                    context.read<ClientBloc>().add(GetListClientEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "Клиенты",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.group_outlined),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "Автомобили",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ReceiverNavBloc, ReceiverNavState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case ReceiverInViewClientsState:
                    return ClientCards(width:cardWidth, height: cardHeight);
                  case ReceiverInViewCarsState:
                    //return AddAutopartPage(width: cardWidth, autopart: state.autopartEdit!);
                  case ReceiverInViewClientInfoState:
                    return ClientInfoCard(client: state.client!, width: cardWidth, height: cardHeight,);
                  default:
                    return const Center(
                      child: Text('Что-то не работает'),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
