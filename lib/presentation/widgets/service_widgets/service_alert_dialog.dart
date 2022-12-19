import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/blocs/service_bloc/service_bloc.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDialogs {
  static final GlobalKey<FormState> key = GlobalKey<FormState>();

  static Future openDialog(
          {required BuildContext context,
          ServiceDto? service,
          required ServiceBloc bloc,
          required StorekeeperNavBloc navBloc,
          required List<ServiceTypeDto> menuItems}) =>
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: BlocListener<ServiceBloc, ServiceState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is FormSubmissionFailed) {
                SnackBarInfo.show(
                    context: context,
                    message: formStatus.exception.toString(),
                    isSuccess: false);
              } else if (formStatus is FormSubmissionSuccess<ServiceDto>) {
                SnackBarInfo.show(
                    context: context,
                    message:
                        service == null ? 'Работа создана' : 'Работа изменена',
                    isSuccess: true);
              }
            },
            child: AlertDialog(
              title: Text(service == null
                  ? 'Добавление работы в сервисе'
                  : 'Изменение работы в сервисе'),
              content: BlocBuilder<ServiceBloc, ServiceState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: key,
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: service?.description ?? '',
                            validator: (value) {
                              if (value!.length > 50) {
                                return "Слишком длинное название!";
                              }
                              return value.isNotEmpty
                                  ? null
                                  : "Это обязательное поле";
                            },
                            onChanged: (value) {
                              bloc.add(ServiceDescriptionChangedEvent(value));
                            },
                            maxLines: 1,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.description),
                              border: OutlineInputBorder(),
                              labelText: "Описание работы",
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            initialValue: service?.price.toString() ?? '',
                            validator: (value) {
                              if (double.tryParse(value!) == null) {
                                return 'Поле должно состоять из цифр';
                              } else if (double.parse(value) <= 0) {
                                return "Число должно быть больше нуля";
                              }
                              return value.isNotEmpty
                                  ? null
                                  : "Это обязательное поле";
                            },
                            onChanged: (value) {
                              bloc.add(ServiceDescriptionChangedEvent(value));
                            },
                            maxLines: 1,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.wallet),
                              border: OutlineInputBorder(),
                              labelText: "Стоимость",
                            ),
                          ),
                          const SizedBox(height: 20),
                          dropDownCategories(
                            bloc: bloc,
                            context: context,
                            service: service,
                            menuItems: menuItems,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                BlocBuilder<ServiceBloc, ServiceState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return state.formStatus is FormSubmitting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                service == null
                                    ? bloc.add(FormSubmittedEvent(
                                        state.description,
                                        state.type!,
                                        state.price))
                                    : bloc.add(
                                        FormSubmittedUpdateEvent(
                                          id: service.id!,
                                          description: state.description,
                                          price: state.price,
                                          type: state.type!,
                                        ),
                                      );
                                key.currentState!.reset();
                                bloc.add(GetListServicesEvent());
                                navBloc.add(ToViewServicesEvent());
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                                service == null ? 'Добавить' : 'Изменить'));
                  },
                )
              ],
            ),
          ),
        ),
      );

  static Widget dropDownCategories(
      {required BuildContext context,
      required List<ServiceTypeDto> menuItems,
      ServiceDto? service,
      required ServiceBloc bloc}) {
    late List<DropdownMenuItem<ServiceTypeDto>> menuItemsDropDown = menuItems
        .map((type) => DropdownMenuItem<ServiceTypeDto>(
              value: type,
              child: Text(type.name!),
            ))
        .toList();

    ServiceTypeDto? _selectedItem;
    return BlocListener<ServiceBloc, ServiceState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess<ServiceDto>) {
          key.currentState!.reset();
          _selectedItem = null;
        }
      },
      child: BlocBuilder<ServiceBloc, ServiceState>(
        bloc: bloc,
        builder: (context, state) {
          return DropdownButtonFormField(
            //TODO:СДелать валидатор
            // validator: (value) =>
            //     AutopartValidation.validated(state: state).categoryMessage,
            icon: const Icon(Icons.category_outlined),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: service != null
                ? menuItemsDropDown
                        .where((type) => type.value!.id == service.type!.id)
                        .first
                        .value ??
                    _selectedItem
                : _selectedItem,
            elevation: 4,
            hint: const Text('Тип работ'),
            items: menuItemsDropDown,
            onChanged: (ServiceTypeDto? type) {
              _selectedItem = type;
              bloc.add(ServiceTypeChangedEvent(type!));
            },
          );
        },
      ),
    );
  }
}
