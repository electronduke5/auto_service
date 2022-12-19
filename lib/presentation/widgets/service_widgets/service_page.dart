import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/blocs/service_bloc/service_bloc.dart';
import 'package:auto_service/blocs/service_type_bloc/type_bloc.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/presentation/widgets/service_widgets/service_alert_dialog.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesViewPage extends StatelessWidget {
  const ServicesViewPage({Key? key, required this.width}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<ServiceBloc, ServiceState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case InitialModelsStatus:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<ServiceDto>:
                  return _servicesGridView(state, width, context);

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

  Widget _servicesGridView(
      ServiceState state, double width, BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, stateDelete) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return _serviceViewCard(
                context: context,
                service:
                    (state.modelsStatus.entities as List<ServiceDto>)[index]);
          },
          itemCount: (state.modelsStatus.entities as List<ServiceDto>).length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            childAspectRatio: width / width * 1,
            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.2,
          ),
        );
      },
    );
  }

  Widget _serviceViewCard(
      {required BuildContext context, required ServiceDto service}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Описание: "${service.description!}"',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Категория: ${service.type!.name}",
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                Text(
                  "Стоимость ремонта: ${service.price} руб.",
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlocBuilder<TypeBloc, TypeState>(
                      builder: (context, stateType) {
                        return OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.amber),
                          ),
                          onPressed: () {
                            context
                                .read<ServiceBloc>()
                                .add(EditFormServiceInitialEvent(service));
                            ServiceDialogs.openDialog(
                              context: context,
                              bloc: context.read<ServiceBloc>(),
                              service: service,
                              navBloc: context.read<StorekeeperNavBloc>(),
                              menuItems: stateType.modelsStatus.entities
                                  as List<ServiceTypeDto>,
                            );
                          },
                          child: const Icon(Icons.edit, color: Colors.amber),
                        );
                      },
                    ),
                    SizedBox(width: width * 0.01),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).errorColor),
                      ),
                      onPressed: () {
                        context
                            .read<ServiceBloc>()
                            .add(DeleteServiceEvent(service.id!));
                        SnackBarInfo.show(
                            context: context,
                            message:
                                'Работа ${service.description}  успешно удалена!',
                            isSuccess: true);

                        context.read<ServiceBloc>().add(GetListServicesEvent());
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
