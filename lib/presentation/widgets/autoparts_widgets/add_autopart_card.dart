import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/validation/autopart_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAutopartCard extends StatelessWidget {
  AddAutopartCard({
    Key? key,
    required this.width,
    required this.menuItems,
    this.autopart,
  }) : super(key: key);

  final double width;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AutopartDto? autopart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutopartBloc, AutopartState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  autopart == null ? 'Заказ запчасти' : 'Изменение',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: autopart?.name,
                      validator: (value) =>
                          AutopartValidation.validated(state: state)
                              .nameMessage,
                      onChanged: (value) =>
                          context.read<AutopartBloc>().add(NameChanged(value)),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.edit_note_outlined),
                        border: OutlineInputBorder(),
                        labelText: "Название",
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      enabled: autopart == null,
                      initialValue: autopart?.purchasePrice.toString(),
                      validator: (value) =>
                          AutopartValidation.validated(state: state)
                              .purchaseMessage,
                      onChanged: (value) => context
                          .read<AutopartBloc>()
                          .add(PurchasePriceChanged(value)),
                      maxLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: autopart != null
                            ? Icon(
                                Icons.edit_off_outlined,
                                color: Theme.of(context).errorColor,
                              )
                            : null,
                        prefixIcon: const Icon(Icons.money),
                        border: const OutlineInputBorder(),
                        labelText: "Закупочная цена",
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      enabled: autopart == null,
                      initialValue: autopart?.salePrice.toString(),
                      validator: (value) =>
                          AutopartValidation.validated(state: state)
                              .saleMessage,
                      onChanged: (value) => context
                          .read<AutopartBloc>()
                          .add(SalePriceChanged(value)),
                      maxLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: autopart != null
                            ? Icon(
                                Icons.edit_off_outlined,
                                color: Theme.of(context).errorColor,
                              )
                            : null,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.money),
                        labelText: "Продажная цена",
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                endIndent: 30,
                indent: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialValue: autopart?.count.toString(),
                      validator: (value) =>
                          AutopartValidation.validated(state: state)
                              .countMessage,
                      onChanged: (value) =>
                          context.read<AutopartBloc>().add(CountChanged(value)),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.onetwothree),
                        border: OutlineInputBorder(),
                        labelText: "Количество",
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: dropDownCategories(context),
                  ),
                  SizedBox(width: width / 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: width / 2),
                  Expanded(
                    child: BlocBuilder<AutopartBloc, AutopartState>(
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
                                    autopart == null
                                        ? context
                                            .read<AutopartBloc>()
                                            .add(FormSubmitted(
                                              name: state.name,
                                              purchasePrice: double.parse(
                                                  state.purchasePrice),
                                              salePrice:
                                                  double.parse(state.salePrice),
                                              count: int.parse(state.count),
                                              category: state.category!,
                                            ))
                                        : context
                                            .read<AutopartBloc>()
                                            .add(FormSubmittedUpdate(
                                              name: state.name,
                                              category: state.category!,
                                              count: int.parse(state.count),
                                              autopart: autopart!,
                                              id: autopart!.id!,
                                            ));
                                    formKey.currentState!.reset();
                                  }
                                },
                                child: Text(
                                  autopart == null ? "Заказать" : "Сохранить",
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

  List<CategoryDto> menuItems;
  late List<DropdownMenuItem<CategoryDto>> menuItemsDropDown = menuItems
      .map((category) => DropdownMenuItem<CategoryDto>(
            value: category,
            child: Text(category.name!),
          ))
      .toList();

  CategoryDto? _selectedItem;

  Widget dropDownCategories(BuildContext context) {
    return BlocListener<AutopartBloc, AutopartState>(
      listener: (context, state) {
        if (state.formStatus is FormSubmissionSuccess<AutopartDto>) {
          formKey.currentState!.reset();
          _selectedItem = null;
        }
      },
      child: BlocBuilder<AutopartBloc, AutopartState>(
        builder: (context, state) {
          return DropdownButtonFormField(
            validator: (value) =>
                AutopartValidation.validated(state: state).categoryMessage,
            icon: const Icon(Icons.category_outlined),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: autopart != null
                ? menuItemsDropDown
                        .where((category) =>
                            category.value!.id == autopart!.category!.id)
                        .first
                        .value ??
                    _selectedItem
                : _selectedItem,
            elevation: 4,
            hint: const Text('Категория'),
            items: menuItemsDropDown,
            onChanged: (CategoryDto? category) {
              _selectedItem = category;
              context.read<AutopartBloc>().add(CategoryChanged(category!));
            },
          );
        },
      ),
    );
  }
}
