import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:auto_service/presentation/widgets/order_widgets/count_autopart_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutopartsListView extends StatefulWidget {
  AutopartsListView(
      {Key? key, required this.autoparts, required this.formKey, this.order})
      : super(key: key);
  final List<AutopartDto> autoparts;
  final GlobalKey<FormState> formKey;
  final OrderDto? order;


  @override
  State<AutopartsListView> createState() => _AutopartsListViewState();
}

class _AutopartsListViewState extends State<AutopartsListView> {
  final Map<AutopartDto, int> _selectedList = <AutopartDto, int>{};
  void _onAutopartSelected(
      bool isSelected, AutopartDto autopart, BuildContext context) async {
    if (isSelected) {
      int count = await OrderDialogs.openCountAutopartDialog(
          context, autopart, context.read<OrderBloc>());
      _selectedList.addEntries([MapEntry(autopart, count)]);
      print('count from alert: $count');
      print('selected items count: ${_selectedList.length}');
      for (var item in _selectedList.entries) {
        print('autopart: ${item.key.name}');
        print('count: ${item.value}');
      }
    } else {
      print(autopart.name);
      print('selected items count: ${_selectedList.length}');
      _selectedList.remove(autopart);
    }

    setState(() {
      context.read<OrderBloc>().add(
          AutopartsChangedInOrderEvent(_selectedList.keys.toList()));
      context.read<OrderBloc>().add(AutopartsCountChangedInOrderEvent(
          _selectedList.values.toList()));
      // print(context.read<OrderBloc>().state.autopartsAdd!.length);
      // print(context.read<OrderBloc>().state.autopartsCount!.length);
    });
  }

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.autoparts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: widget.autoparts.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            activeColor: Theme.of(context).colorScheme.background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            value: _isChecked[index],
            onChanged: (value) {
              _onAutopartSelected(value!, widget.autoparts[index], context);
              _isChecked[index] = value;
            },
            title: IntrinsicHeight(
              child: Row(
                children: [
                  Text('${widget.autoparts[index].name}'),
                  const VerticalDivider(),
                  Text('${widget.autoparts[index].salePrice} руб'),
                  const VerticalDivider(),
                  Text('${widget.autoparts[index].count} шт'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
