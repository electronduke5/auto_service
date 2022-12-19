import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/domain/emuns/order_status_enum.dart';
import 'package:auto_service/presentation/widgets/order_widgets/autoparts_listview.dart';
import 'package:auto_service/presentation/widgets/order_widgets/car_dropdown.dart';
import 'package:auto_service/presentation/widgets/order_widgets/services_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrderCard extends StatelessWidget {
  AddOrderCard({
    Key? key,
    required this.width,
    required this.navigationState,
    this.order,
    required this.cars,
    required this.autoparts,
    required this.services, required this.loggedEmployee,
  }) : super(key: key);

  final double width;
  final ReceiverNavState navigationState;
  final OrderDto? order;
  final List<CarDto> cars;
  final List<AutopartDto> autoparts;
  final List<ServiceDto> services;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EmployeeDto loggedEmployee;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  navigationState is ReceiverInAddOrderState
                      ? "Создание заказ-наряда"
                      : "Изменение заказ-наряда",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  Expanded(
                    child: CarDropDown(
                      formKey: formKey,
                      cars: cars,
                      order: order,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Divider(
                endIndent: 30,
                indent: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: width / 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Виды работ',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Divider(),
                        ServicesListView(
                          services: services,
                          formKey: formKey,
                          order: order,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Запчасти',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Divider(),
                        AutopartsListView(
                          autoparts: autoparts..removeWhere((element) => element.count == 0),
                          formKey: formKey,
                          order: order,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: width / 10),
                ],
              ),
              const Divider(
                endIndent: 30,
                indent: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: width / 2),
                  Expanded(
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return state.formStatus is FormSubmitting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).focusColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    order == null
                                        ? context.read<OrderBloc>().add(
                                              OrderFormSubmittedEvent(
                                                status: StatusEnum.confirmed,
                                                car: state.car!,
                                                employee: loggedEmployee,
                                                autoparts: state.autopartsAdd,
                                                autopartsCount: state.autopartsCount,
                                                services: state.servicesAdd,
                                              ),
                                            )
                                        : context.read<OrderBloc>().add(OrderFormSubmittedUpdateEvent(
                                      id: order!.id!,
                                      status: StatusEnum.values.singleWhere((element) => element.status == order?.status),
                                      car: state.car!,
                                      employee: loggedEmployee,
                                      autoparts: state.autopartsAdd,
                                      autopartsCount: state.autopartsCount,
                                      services: state.servicesAdd,
                                    ),);
                                  }
                                },
                                child: Text(
                                  navigationState is ReceiverInAddOrderState
                                      ? "Добавить"
                                      : "Изменить",
                                ),
                              );
                      },
                    ),
                  ),
                  SizedBox(width: width / 2),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  late List<DropdownMenuItem<CarDto>> carsItems = cars
      .map(
        (car) => DropdownMenuItem<CarDto>(
          value: car,
          child: Text('${car.model.toString()} | ${car.carNumber.toString()}'),
        ),
      )
      .toList();

  CarDto? _selectedCar;

  Widget dropDownCar(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess<OrderDto>) {
          formKey.currentState!.reset();
          _selectedCar = null;
        }
      },
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return DropdownButtonFormField(
            //validator: (value) => CarValidator.validated(state).clientMessage,
            icon: const Icon(Icons.account_circle_outlined),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: order != null
                ? carsItems
                        .where((car) => car.value!.id == order!.car!.id)
                        .first
                        .value ??
                    _selectedCar
                : _selectedCar,
            elevation: 4,
            hint: const Text('Авто'),
            items: carsItems,
            onChanged: (CarDto? car) {
              _selectedCar = car;
              context.read<OrderBloc>().add(CarChangedInOrderEvent(car!));
            },
          );
        },
      ),
    );
  }
}
