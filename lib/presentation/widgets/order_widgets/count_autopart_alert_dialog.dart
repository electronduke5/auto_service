import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDialogs {
  static final GlobalKey<FormState> editCountKey = GlobalKey<FormState>();
  static final TextEditingController countController = TextEditingController();

  static Future openCountAutopartDialog(
          BuildContext context, AutopartDto autopart, OrderBloc bloc) =>
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {},
            child: AlertDialog(
              title: const Text('Количество запчастей'),
              content: BlocBuilder<OrderBloc, OrderState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: editCountKey,
                    child: TextFormField(
                      controller: countController,
                      validator: (value) {
                        if(int.parse(value!) <= 0) {
                          return 'Только положительное число';
                        }else if(int.parse(value) > autopart.count!){
                          return 'Максимум ${autopart.count} запчастей';
                        }
                      },
                      onChanged: (value) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.onetwothree),
                        border: OutlineInputBorder(),
                        labelText: "Количество",
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
                BlocBuilder<OrderBloc, OrderState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () {
                          if (editCountKey.currentState!.validate()) {


                            print(countController.text);
                            print(int.parse(countController.text));
                            Navigator.of(context).pop(int.parse(countController.text));
                            editCountKey.currentState!.reset();
                          }
                        },
                        child: const Text('Ок'));
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
