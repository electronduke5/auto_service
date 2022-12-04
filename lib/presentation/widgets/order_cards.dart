import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/order_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCards extends StatelessWidget {
  const OrderCards({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            children: const [
              Text('Sorting'),
              SizedBox(width: 40),
              Text('Search'),
              SizedBox(width: 40),
              Text('Filter'),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<OrderDto>:
                  return _orderGridView(state, width, height, context);

                case SubmissionFailed:
                  {
                    return Center(
                      child:
                      Text(state.modelsStatus.error ?? 'Submission Failed'),
                    );
                  }
                default:
                  return const Center(
                    child: Text("Непредвиденная ошибка"),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _orderGridView(
      OrderState state, double width, double height, BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, stateDelete) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            childAspectRatio: width / height * 0.7,
            crossAxisCount: 4,
          ),
          itemCount: (state.modelsStatus.entities as List<OrderDto>).length,
          itemBuilder: (context, index) {
            return _orderViewCard(
                context: context,
                order: (state.modelsStatus.entities as List<OrderDto>)[index]);
          },
        );
      },
    );
  }

  Widget _orderViewCard({required BuildContext context, required OrderDto order}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: orderModelItem(
                    value: "Статус: ${order.status!}", icon: Icons.timer_outlined),
              ),
              const Divider(),
              orderModelItem(
                  value: 'Клиент: ${order.client!.getFullName()}', icon: Icons.account_circle_outlined),
              orderModelItem(
                  value: 'Авто: ${order.car!.model}', icon: Icons.time_to_leave),
              orderModelItem(
                  value: 'Сотрудник: ${order.employee!.getFullName()}', icon: Icons.account_box_outlined),
              orderModelItem(
                  value: 'Кол-во запчастей: ${order.autoparts!.length}', icon: Icons.local_fire_department_outlined),
              orderModelItem(
                  value: 'Кол-во ремонтов: ${order.services!.length}', icon: Icons.discount_outlined),
              // TextButton.icon(
              //   style: TextButton.styleFrom(
              //     padding: const EdgeInsets.only(right: 10),
              //   ),
              //   onPressed: () {},
              //   icon: const Icon(Icons.build_circle_outlined),
              //   label: Text('Количество ремонтов: ${order.orders ?? 0}'),
              // ),
              // TextButton.icon(
              //   style: TextButton.styleFrom(
              //     padding: const EdgeInsets.only(right: 10),
              //   ),
              //   onPressed: () {
              //     context
              //         .read<ReceiverNavBloc>()
              //         .add(ToViewClientInfoEvent(order.client!));
              //   },
              //   icon: const Icon(Icons.account_circle_outlined),
              //   label: Text('Владелец: ${order.client?.getFullName()}'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderModelItem({required String value, required IconData icon}) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(icon),
          ),
          TextSpan(text: '  $value'),
        ],
      ),
    );
  }

  Widget orderModelItemButton({required String value, required IconData icon}) {
    return TextButton.icon(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {},
      icon: Icon(icon),
      label: Text(' $value'),
    );
  }
}
