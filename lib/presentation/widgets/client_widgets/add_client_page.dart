import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/presentation/widgets/client_widgets/add_client_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddClientPage extends StatelessWidget {
  AddClientPage(
      {Key? key,
      required this.height,
      required this.width,
      required this.navigationState,
      this.client})
      : super(key: key);
  final double height;
  final double width;
  final addCarFormKey = GlobalKey<FormState>();
  final editCarFormKey = GlobalKey<FormState>();
  final ReceiverNavState navigationState;
  final ClientDto? client;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 2),
      child: BlocListener<ClientBloc, ClientState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormSubmissionFailed) {
            SnackBarInfo.show(
                context: context,
                message: formStatus.exception.toString(),
                isSuccess: false);
          } else if (formStatus is FormSubmissionSuccess<ClientDto>) {
            SnackBarInfo.show(
                context: context,
                message: navigationState is ReceiverInAddCarState
                    ? 'Клиент успешно доавблен в систему'
                    : 'Данные клиента обновлены',
                isSuccess: true);
            context.read<ReceiverNavBloc>().add(ToViewClientsEvent());
            context.read<ClientBloc>().add(GetListClientEvent());
          }
        },
        child: ClientAddCard(
          navigationState: navigationState,
          client: client,
          width: width,
        ),
      ),
    );
  }
}
