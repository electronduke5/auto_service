import 'package:auto_service/blocs/cars/car_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/data/dto/car_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarCards extends StatelessWidget {
  const CarCards({Key? key, required this.width, required this.height})
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
          child: BlocBuilder<CarBloc, CarState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<CarDto>:
                  return _carGridView(state, width, height, context);

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

  Widget _carGridView(
      CarState state, double width, double height, BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, stateDelete) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            childAspectRatio: width / height * 0.7,
            crossAxisCount: 4,
          ),
          itemCount: (state.modelsStatus.entities as List<CarDto>).length,
          itemBuilder: (context, index) {
            return _carViewCard(
                context: context,
                car: (state.modelsStatus.entities as List<CarDto>)[index]);
          },
        );
      },
    );
  }

  Widget _carViewCard({required BuildContext context, required CarDto car}) {
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
                child: carModelItem(
                    value: "Модель: ${car.model!}", icon: Icons.drive_eta),
              ),
              const Divider(),
              carModelItem(
                  value: 'Рег. номер: ${car.carNumber!}', icon: Icons.filter_1),
              carModelItem(
                  value: 'VIN номер: ${car.vinNumber!}', icon: Icons.filter_2),
              carModelItem(
                  value: 'Пробег: ${car.mileage!}', icon: Icons.av_timer),
              TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(right: 10),
                ),
                onPressed: () {
                  if (car.orders!.isNotEmpty) {
                    context.read<OrderBloc>().add(GetOrdersByCarEvent(car.id!));
                    context.read<ReceiverNavBloc>().add(ToViewOrdersEvent());
                  }
                },
                icon: const Icon(Icons.build_circle_outlined),
                label: Text('Количество ремонтов: ${car.orders!.length}'),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(right: 10),
                ),
                onPressed: () {
                  context
                      .read<ReceiverNavBloc>()
                      .add(ToViewClientInfoEvent(car.client!));
                },
                icon: const Icon(Icons.account_circle_outlined),
                label: Text('Владелец: ${car.client?.getFullName()}'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carModelItem({required String value, required IconData icon}) {
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

  Widget carModelItemButton({required String value, required IconData icon}) {
    return TextButton.icon(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {},
      icon: Icon(icon),
      label: Text(' $value'),
    );
  }
}
