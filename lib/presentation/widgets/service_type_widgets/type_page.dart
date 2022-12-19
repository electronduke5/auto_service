import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/blocs/service_type_bloc/type_bloc.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/presentation/widgets/service_type_widgets/service_type_alert_dialogs.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypesViewPage extends StatelessWidget {
  const TypesViewPage({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<TypeBloc, TypeState>(
            builder: (context, state) {
              print('type status: ${state.modelsStatus.runtimeType}');
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case InitialModelsStatus:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<ServiceTypeDto>:
                  return _typesGridView(state, width, context);

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

  Widget _typesGridView(TypeState state, double width,
      BuildContext context) {
    return BlocBuilder<TypeBloc, TypeState>(
      builder: (context, stateDelete) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return _typeViewCard(
                context: context,
                type:
                (state.modelsStatus.entities as List<ServiceTypeDto>)[index]);
          },
          itemCount: (state.modelsStatus.entities as List<ServiceTypeDto>).length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            childAspectRatio: width / width * 1.4,
            maxCrossAxisExtent: MediaQuery
                .of(context)
                .size
                .width * 0.2,
          ),
        );
      },
    );
  }

  Widget _typeViewCard(
      {required BuildContext context, required ServiceTypeDto type}) {
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
                  'Вид: "${type.name!}"',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                // Text(
                //   "Количество авто: ${client.cars!.length}",
                //   style: TextStyle(color: Theme.of(context).hintColor),
                // ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                      ),
                      onPressed: () {
                        context
                            .read<TypeBloc>()
                            .add(EditFormTypeInitialEvent(type));
                        TypeDialogs.openDialog(context: context, bloc: context.read<TypeBloc>(), type: type, navBloc: context.read<StorekeeperNavBloc>());
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
                            .read<TypeBloc>()
                            .add(DeleteTypeEvent(type.id!));
                        SnackBarInfo.show(
                            context: context,
                            message:
                            'Категория ${type.name}  успешно удалена!',
                            isSuccess: true);

                        context.read<TypeBloc>().add(GetListTypesEvent());
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
