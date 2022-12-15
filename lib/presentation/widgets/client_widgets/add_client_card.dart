import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/data/dto/client_dto.dart';
import 'package:auto_service/validation/client_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientAddCard extends StatelessWidget {
  ClientAddCard(
      {Key? key,
      required this.width,
      required this.navigationState,
      this.client})
      : super(key: key);
  final double width;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ReceiverNavState navigationState;
  final ClientDto? client;
  final _maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  navigationState is ReceiverInAddClientState
                      ? "Добавление клиента"
                      : "Изменение клиента",
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
                    initialValue: client?.surname ?? "",
                    validator: (value) => ClientValidation.isValidSurname(value.toString()).message,
                    onChanged: (value) => context
                        .read<ClientBloc>()
                        .add(ClientSurnameChanged(value)),
                    maxLines: 1,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      hintText: 'Иванов',
                      counterText: '',
                      prefixIcon: Icon(Icons.filter_1),
                      border: OutlineInputBorder(),
                      labelText: "Фамилия",
                    ),
                  )),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      initialValue: client?.name ?? "",
                      validator: (value) => ClientValidation.isValidName(value.toString()).message,
                      onChanged: (value) => context
                          .read<ClientBloc>()
                          .add(ClientNameChanged(value)),
                      maxLines: 1,
                      maxLength: 30,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.filter_2),
                        labelText: "Имя",
                        hintText: 'Иван',
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      initialValue: client?.patronymic.toString() == 'null' ? "" : client?.patronymic.toString(),
                      onChanged: (value) => context
                          .read<ClientBloc>()
                          .add(ClientPatronymicChanged(value)),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.filter_3),
                        border: OutlineInputBorder(),
                        labelText: "Отчество",
                        hintText: 'Иванович',
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
                      inputFormatters: [_maskFormatter],
                      initialValue: client?.phoneNumber ?? "",
                      validator: (value) {
                        return ClientValidation.isValidPhoneNumber(value.toString()).message;
                      },
                      onChanged: (value) => context
                          .read<ClientBloc>()
                          .add(ClientPhoneNumberChanged(_maskFormatter.getMaskedText())),
                      maxLines: 1,
                      maxLength: 18,
                      decoration: const InputDecoration(
                        hintText: '+7 (000) 000-00-00',
                        counterText: '',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: "Номер телефона",
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
                  SizedBox(width: width / 2),
                  Expanded(
                    child: BlocBuilder<ClientBloc, ClientState>(
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
                                    client == null
                                        ? context.read<ClientBloc>().add(
                                              ClientFormSubmitted(
                                                surname: state.surname,
                                                name: state.name,
                                                patronymic: state.patronymic,
                                                phoneNumber: state.phoneNumber,
                                              ),
                                            )
                                        : context.read<ClientBloc>().add(
                                              ClientFormSubmittedUpdate(
                                                id: client!.id!,
                                                surname: state.surname,
                                                name: state.name,
                                                patronymic: state.patronymic,
                                                phoneNumber: state.phoneNumber,
                                              ),
                                            );
                                  }
                                },
                                child: Text(
                                  navigationState is ReceiverInAddClientState
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
}
