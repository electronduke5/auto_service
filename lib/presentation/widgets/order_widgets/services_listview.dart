import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/data/dto/service_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesListView extends StatefulWidget {
  ServicesListView(
      {Key? key, required this.services, required this.formKey, this.order})
      : super(key: key);
  final List<ServiceDto> services;
  final GlobalKey<FormState> formKey;
  final OrderDto? order;

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  final List<ServiceDto> _selectedList = <ServiceDto>[];

  void _onServiceSelected(bool isSelected, ServiceDto service) {
    isSelected ? _selectedList.add(service) : _selectedList.remove(service);
    print('selected services count: ${_selectedList.length}');

    setState(() {
      context.read<OrderBloc>().add(ServicesChangedInOrderEvent(_selectedList));
    });
    print(
        'context servicesAdd: ${context.read<OrderBloc>().state.servicesAdd}');
    print('context services: ${context.read<OrderBloc>().state.services}');
  }

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.services.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: widget.services.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            activeColor: Theme.of(context).colorScheme.background,
            value: _isChecked[index],
            onChanged: (value) {
              _onServiceSelected(value!, widget.services[index]);
              _isChecked[index] = value;
            },
            title: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Card(
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.services[index].description}'),
                        const Divider(),
                        Text(
                            'Стоимость: ${widget.services[index].price.toString()} руб'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
