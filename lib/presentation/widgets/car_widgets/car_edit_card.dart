import 'package:auto_service/blocs/cars/car_bloc.dart';
import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/validation/car_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CarEditCard extends StatelessWidget {
  CarEditCard(
      {Key? key,
      required this.width,
      required this.navigationState,
      this.car,
      required this.menuItems})
      : super(key: key);
  final double width;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ReceiverNavState navigationState;
  final CarDto? car;

  final _maskFormatter = MaskTextInputFormatter(
      mask: 'a###aa###',
      filter: {"#": RegExp(r'[0-9]'), 'a': RegExp(r'[авекмнорстух]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  navigationState is ReceiverInAddCarState
                      ? "Добавление автомобиля"
                      : "Изменение автомобиля",
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
                  SizedBox(width: width / 10),
                  Expanded(
                      child: TextFormField(
                    initialValue: car?.model ?? "",
                    validator: (value) =>
                        CarValidator.isValidModel(model: value.toString())
                            .message,
                    onChanged: (value) =>
                        context.read<CarBloc>().add(ModelChanged(value)),
                    maxLines: 1,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.drive_eta),
                      border: OutlineInputBorder(),
                      labelText: "Модель",
                    ),
                  )),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [_maskFormatter],
                      initialValue: car?.carNumber ?? "",
                      validator: (value) {
                        return CarValidator.isValidCarNumber(
                                number: value!.toLowerCase())
                            .message;
                      },
                      onChanged: (value) =>
                          context.read<CarBloc>().add(CarNumberChanged(value)),
                      maxLines: 1,
                      maxLength: 9,
                      decoration: const InputDecoration(
                        hintText: 'х001хх134',
                        counterText: '',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.filter_1),
                        labelText: "Рег. номер",
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      initialValue: car?.mileage.toString() ?? "",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      validator: (value) {
                        return CarValidator.isValidMileage(
                                mileage: value.toString())
                            .message;
                      },
                      onChanged: (value) => context
                          .read<CarBloc>()
                          .add(MileageChanged(double.parse(value))),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        suffix: Text('км'),
                        prefixIcon: Icon(Icons.av_timer),
                        border: OutlineInputBorder(),
                        labelText: "Пробег",
                      ),
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
                  SizedBox(width: width / 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: car?.vinNumber ?? "",
                      validator: (value) {
                        return CarValidator.isValidVinNumber(
                                number: value!.toUpperCase())
                            .message;
                      },
                      onChanged: (value) =>
                          context.read<CarBloc>().add(VinNumberChanged(value)),
                      maxLines: 1,
                      maxLength: 17,
                      decoration: InputDecoration(
                        suffixText:
                            '${context.read<CarBloc>().state.vinNumber.length.toString()} / 17',
                        counterText: '',
                        prefixIcon: const Icon(Icons.filter_2),
                        border: const OutlineInputBorder(),
                        labelText: "VIN номер",
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: dropDownClients(context),
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
                    child: BlocBuilder<CarBloc, CarState>(
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
                                    car == null
                                        ? context.read<CarBloc>().add(
                                              FormSubmitted(
                                                model: state.model,
                                                carNumber: state.carNumber,
                                                vinNumber: state.vinNumber,
                                                mileage: state.mileage,
                                                client: state.client!,
                                              ),
                                            )
                                        : context.read<CarBloc>().add(
                                              FormSubmittedUpdate(
                                                id: car!.id!,
                                                model: state.model,
                                                carNumber: state.carNumber,
                                                vinNumber: state.vinNumber,
                                                mileage: state.mileage,
                                                client: state.client!,
                                              ),
                                            );
                                  }
                                },
                                child: Text(
                                  navigationState is ReceiverInAddCarState
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

  List<ClientDto> menuItems;
  late List<DropdownMenuItem<ClientDto>> menuItemsDropDown = menuItems
      .map((client) => DropdownMenuItem<ClientDto>(
            value: client,
            child: Text(client.getFullName()),
          ))
      .toList();

  ClientDto? _selectedItem;

  Widget dropDownClients(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess<CarDto>) {
          formKey.currentState!.reset();
          _selectedItem = null;
        }
      },
      child: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          return DropdownButtonFormField(
            validator: (value) => CarValidator.validated(state).clientMessage,
            icon: const Icon(Icons.account_circle_outlined),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: car != null
                ? menuItemsDropDown
                        .where((client) => client.value!.id == car!.client!.id)
                        .first
                        .value ??
                    _selectedItem
                : _selectedItem,
            elevation: 4,
            hint: const Text('Владелец'),
            items: menuItemsDropDown,
            onChanged: (ClientDto? client) {
              _selectedItem = client;
              context.read<CarBloc>().add(ClientChanged(client!));
            },
          );
        },
      ),
    );
  }
}
