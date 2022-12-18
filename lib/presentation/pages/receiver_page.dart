import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/cars/car_bloc.dart';
import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/blocs/service_bloc/service_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:auto_service/presentation/widgets/car_widgets/add_car_widget.dart';
import 'package:auto_service/presentation/widgets/car_widgets/car_cards.dart';
import 'package:auto_service/presentation/widgets/client_widgets/add_client_page.dart';
import 'package:auto_service/presentation/widgets/client_widgets/client_cards.dart';
import 'package:auto_service/presentation/widgets/client_widgets/client_info_card.dart';
import 'package:auto_service/presentation/widgets/order_widgets/add_order_page.dart';
import 'package:auto_service/presentation/widgets/order_widgets/order_cards.dart';
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

  Widget _buildReceiverBody(BuildContext context, double cardWidth,
      double cardHeight, EmployeeDto loggedEmployee) {
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
                    context.read<ReceiverNavBloc>().add(ToViewClientsEvent());
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
                  onPressed: () {
                    context.read<ReceiverNavBloc>().add(ToViewCarsEvent());
                    context.read<CarBloc>().add(GetListCarEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "Автомобили",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.library_books_outlined),
                  onPressed: () {
                    context.read<ReceiverNavBloc>().add(ToViewOrdersEvent());
                    context.read<OrderBloc>().add(GetListOrdersEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "Orders",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.library_books_outlined),
                  onPressed: () {
                    context.read<ReceiverNavBloc>().add(ToAddCarEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "+ Авто",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add_alt_outlined),
                  onPressed: () {
                    context.read<ReceiverNavBloc>().add(ToAddClientEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "+ Клиент",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add_alt_outlined),
                  onPressed: () {
                    context.read<ReceiverNavBloc>().add(ToAddOrderEvent());
                  },
                  style: ElevatedButton.styleFrom(elevation: 7),
                  label: const Text(
                    "+ Order",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocListener<ReceiverNavBloc, ReceiverNavState>(
              listener: (context, state) {
                if (state is ReceiverInAddOrderState) {
                  context.read<ServiceBloc>().add(GetListServicesEvent());
                  context.read<CarBloc>().add(GetListCarEvent());
                  context.read<AutopartBloc>().add(GetListAutopartsEvent());
                }
              },
              child: BlocBuilder<ReceiverNavBloc, ReceiverNavState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case ReceiverInViewClientsState:
                      return ClientCards(width: cardWidth, height: cardHeight);
                    case ReceiverInViewCarsState:
                      return CarCards(width: cardWidth, height: cardHeight);
                    case ReceiverInViewClientInfoState:
                      return ClientInfoCard(
                        client: state.client!,
                        width: cardWidth,
                        height: cardHeight,
                      );
                    case ReceiverInViewOrdersState:
                      return OrderCards(width: cardWidth, height: cardHeight);
                    case ReceiverInAddCarState:
                      return AddCarCard(
                        width: cardWidth,
                        height: cardHeight,
                        navigationState: state,
                      );
                    case ReceiverInEditCarState:
                      return AddCarCard(
                        width: cardWidth,
                        height: cardHeight,
                        navigationState: state,
                        car: state.carEdit,
                      );
                    case ReceiverInAddClientState:
                      return AddClientPage(
                        width: cardWidth,
                        height: cardHeight,
                        navigationState: state,
                      );
                    case ReceiverInEditClientState:
                      return AddClientPage(
                        client: state.client,
                        width: cardWidth,
                        height: cardHeight,
                        navigationState: state,
                      );
                    case ReceiverInAddOrderState:
                      return AddOrderPage(
                        loggedEmployee: loggedEmployee,
                        width: cardWidth,
                        height: cardHeight,
                        navigationState: state,
                      );
                    case ReceiverInEditOrderState:
                      return AddOrderPage(
                        loggedEmployee: loggedEmployee,
                        order: state.orderEdit,
                        width: cardWidth,
                        height: cardHeight,
                        navigationState: state,
                      );
                    default:
                      return const Center(
                        child: Text('Что-то не работает'),
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
