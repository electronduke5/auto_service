import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/cars/car_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/presentation/widgets/order_widgets/add_order_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/service_bloc/service_bloc.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({
    Key? key,
    required this.height,
    required this.width,
    this.order,
    required this.navigationState,
  }) : super(key: key);

  final double height;
  final double width;
  final OrderDto? order;
  final ReceiverNavState navigationState;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 3),
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormSubmissionFailed) {
            SnackBarInfo.show(
                context: context,
                message: formStatus.exception.toString(),
                isSuccess: false);
          } else if (formStatus is FormSubmissionSuccess<OrderDto>) {
            SnackBarInfo.show(
                context: context,
                message: navigationState is ReceiverInAddCarState
                    ? 'Автомобиль успешно доавблен в систему'
                    : 'Данные автомобиля обновлены',
                isSuccess: true);
            context.read<ReceiverNavBloc>().add(ToViewOrdersEvent());
            context.read<OrderBloc>().add(GetListOrdersEvent());
          }
        },
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, carState) {
            print('carState is ${carState.modelsStatus.runtimeType}');
            return carState.modelsStatus is SubmissionSuccess<CarDto>
                ? BlocBuilder<AutopartBloc, AutopartState>(
                    builder: (context, autopartState) {
                      print(
                          'autopartState is ${autopartState.modelsStatus.runtimeType}');
                      return autopartState.modelsStatus
                              is SubmissionSuccess<AutopartDto>
                          ? BlocBuilder<ServiceBloc, ServiceState>(
                              builder: (context, serviceState) {
                              print(
                                  'serviceState is ${serviceState.modelsStatus.runtimeType}');
                              return serviceState.modelsStatus
                                      is SubmissionSuccess<ServiceDto>
                                  ? AddOrderCard(
                                      navigationState: navigationState,
                                      order: order,
                                      width: width,
                                      cars: carState.modelsStatus.entities
                                          as List<CarDto>,
                                      autoparts: autopartState.modelsStatus
                                          .entities as List<AutopartDto>,
                                      services: serviceState.modelsStatus
                                          .entities as List<ServiceDto>,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            })
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
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
