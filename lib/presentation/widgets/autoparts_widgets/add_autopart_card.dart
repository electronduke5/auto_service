import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/validation/autopart_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAutopartCard extends StatelessWidget {
  AddAutopartCard({
    Key? key,
    required this.width,
    required this.menuItems,
  }) : super(key: key);

  final double width;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutopartBloc, AutopartState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Заказ запчасти',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) => AutopartValidation.validated(state: state).nameMessage,
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
                      validator:(value) => AutopartValidation.validated(state: state).purchaseMessage,
                      onChanged: (value) => context
                          .read<AutopartBloc>()
                          .add(PurchasePriceChanged(value)),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.money),
                        border: OutlineInputBorder(),
                        labelText: "Закупочная цена",
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                  Expanded(
                    child: TextFormField(
                      validator: (value) => AutopartValidation.validated(state: state).saleMessage,
                      onChanged: (value) => context
                          .read<AutopartBloc>()
                          .add(SalePriceChanged(value)),
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.money),
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
                      validator: (value) => AutopartValidation.validated(state: state).countMessage,
                      onChanged: (value) => context
                          .read<AutopartBloc>()
                          .add(CountChanged(value)),
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
                                    context
                                        .read<AutopartBloc>()
                                        .add(FormSubmitted(
                                          name: state.name,
                                          purchasePrice: double.parse(state.purchasePrice),
                                          salePrice: double.parse(state.salePrice),
                                          count: int.parse(state.count)  ,
                                          category: state.categoryId!,
                                        ));

                                    formKey.currentState!.reset();
                                  }
                                },
                                child: const Text(
                                  "Заказать",
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
            validator: (value) => AutopartValidation.validated(state: state).categoryMessage,
            icon: const Icon(Icons.category_outlined),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: _selectedItem,
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
