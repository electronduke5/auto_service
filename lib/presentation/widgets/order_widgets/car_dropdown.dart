import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDropDown extends StatelessWidget {
  CarDropDown({Key? key, required this.cars, required this.formKey, this.order})
      : super(key: key);

  final List<CarDto> cars;
  final GlobalKey<FormState> formKey;
  final OrderDto? order;

  late List<DropdownMenuItem<CarDto>> carsItems = cars
      .map(
        (car) => DropdownMenuItem<CarDto>(
          value: car,
          child: Text('${car.model.toString()} | ${car.carNumber.toString()}'),
        ),
      )
      .toList();

  CarDto? _selectedCar;

  @override
  Widget build(BuildContext context) {
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
