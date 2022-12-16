import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:flutter/material.dart';

class AutopartsListView extends StatefulWidget {
  AutopartsListView(
      {Key? key, required this.autoparts, required this.formKey, this.order})
      : super(key: key);
  final List<AutopartDto> autoparts;
  final GlobalKey<FormState> formKey;
  final OrderDto? order;
  final List<AutopartDto> _selectedList = <AutopartDto>[];

  @override
  State<AutopartsListView> createState() => _AutopartsListViewState();
}

class _AutopartsListViewState extends State<AutopartsListView> {
  void _onAutopartSelected(bool isSelected, AutopartDto autopart) {
    setState(() {
      isSelected
          ? widget._selectedList.add(autopart)
          : widget._selectedList.remove(autopart);
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
              _onAutopartSelected(value!, widget.autoparts[index]);
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
