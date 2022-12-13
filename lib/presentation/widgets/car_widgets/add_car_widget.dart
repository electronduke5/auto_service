import 'package:auto_service/blocs/cars/car_bloc.dart';
import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/presentation/widgets/car_widgets/car_edit_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarCard extends StatelessWidget {
  AddCarCard(
      {Key? key,
      required this.height,
      required this.width,
      required this.navigationState,
      this.car})
      : super(key: key);
  final double height;
  final double width;
  final addCarFormKey = GlobalKey<FormState>();
  final editCarFormKey = GlobalKey<FormState>();
  final ReceiverNavState navigationState;
  final CarDto? car;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 2),
      child: BlocListener<CarBloc, CarState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormSubmissionFailed) {
            SnackBarInfo.show(
                context: context,
                message: formStatus.exception.toString(),
                isSuccess: false);
          } else if (formStatus is FormSubmissionSuccess<CarDto>) {
            SnackBarInfo.show(
                context: context,
                message: navigationState is ReceiverInAddCarState
                    ? 'Автомобиль успешно доавблен в систему'
                    : 'Данные автомобиля обновлены',
                isSuccess: true);
            context.read<ReceiverNavBloc>().add(ToViewCarsEvent());
            context.read<CarBloc>().add(GetListCarEvent());
          }
        },
        child: BlocBuilder<ClientBloc, ClientState>(
          builder: (context, state) {
            return state.modelsStatus is SubmissionSuccess<ClientDto>
                ? CarEditCard(
                    navigationState: navigationState,
                    car: car,
                    width: width,
                    menuItems: state.modelsStatus.entities as List<ClientDto>,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
