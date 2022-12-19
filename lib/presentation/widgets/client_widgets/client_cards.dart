import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientCards extends StatelessWidget {
  const ClientCards({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<ClientBloc, ClientState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<ClientDto>:
                  return _employeeGridView(state, width, height, context);

                case SubmissionFailed:
                  {
                    return Center(
                      child:
                          Text(state.modelsStatus.error ?? 'Submission Failed'),
                    );
                  }
                default:
                  return const Center(
                    child: Text("Непредвиденная ошибка"),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _employeeGridView(
      ClientState state, double width, double height, BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, stateDelete) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return _clientViewCard(
                context: context,
                client:
                    (state.modelsStatus.entities as List<ClientDto>)[index]);
          },
          itemCount: (state.modelsStatus.entities as List<ClientDto>).length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            childAspectRatio: width / height * 0.7,
            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.2,
          ),
        );
      },
    );
  }

  Widget _clientViewCard(
      {required BuildContext context, required ClientDto client}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.getFullName(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Номер телефона: ${client.phoneNumber}",
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                Text(
                  "Количество авто: ${client.cars!.length}",
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      onPressed: () {
                        context
                            .read<ReceiverNavBloc>()
                            .add(ToViewClientInfoEvent(client));
                      },
                      child: Icon(Icons.info_outline,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    SizedBox(width: width * 0.01),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                      ),
                      onPressed: () {
                        context
                            .read<ClientBloc>()
                            .add(EditFormClientInitial(client));
                        context
                            .read<ReceiverNavBloc>()
                            .add(ToEditClientEvent(client: client));
                      },
                      child: const Icon(Icons.edit, color: Colors.amber),
                    ),
                    SizedBox(width: width * 0.01),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).errorColor),
                      ),
                      onPressed: () {
                        context
                            .read<ClientBloc>()
                            .add(DeleteClientEvent(client.id!));
                        SnackBarInfo.show(
                            context: context,
                            message:
                                'Пользователь ${client.surname} ${client.name} успешно удалён!',
                            isSuccess: true);

                        context.read<ClientBloc>().add(GetListClientEvent());
                      },
                      child: Icon(Icons.delete_outlined,
                          color: Theme.of(context).errorColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
