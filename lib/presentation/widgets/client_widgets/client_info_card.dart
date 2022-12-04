import 'package:auto_service/data/dto/client_dto.dart';
import 'package:flutter/material.dart';

class ClientInfoCard extends StatelessWidget {
  const ClientInfoCard(
      {Key? key,
      required this.client,
      required this.width,
      required this.height})
      : super(key: key);

  final ClientDto client;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.1),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${client.getFullName()}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(Icons.phone),
                    Text(
                      '  Контактный номер: ${client.phoneNumber}',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Builder(
                      builder: (context) {
                        return client.cars == null || client.cars!.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/car_3.png',
                                        height: height * 1.1),
                                    const Text(
                                      'У клиента ещё не добавлено ни одного авто',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  crossAxisSpacing: 10,
                                  childAspectRatio: width / height * 0.6,
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                itemCount: client.cars!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Авто №${index + 1}'),
                                            const Divider(),
                                            carModelItem(
                                                value:
                                                    "Модель: ${client.cars![index].model!}",
                                                icon: Icons.drive_eta),
                                            carModelItem(
                                                value:
                                                    'Рег. номер: ${client.cars![index].carNumber!}',
                                                icon: Icons.filter_1),
                                            carModelItem(
                                                value:
                                                    'VIN номер: ${client.cars![index].vinNumber!}',
                                                icon: Icons.filter_2),
                                            carModelItem(
                                                value:
                                                    'Пробег: ${client.cars![index].mileage!}',
                                                icon: Icons.av_timer),
                                            carModelItem(
                                                value:
                                                    'Количество ремонтов: ${client.cars![index].orders ?? 0}',
                                                icon: Icons
                                                    .build_circle_outlined),
                                            Builder(builder: (context) {
                                              if (client.cars![index].orders !=
                                                  null) {
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Divider(),
                                                    OutlinedButton(
                                                      style:
                                                          OutlinedButton.styleFrom(
                                                        side: BorderSide(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .inversePrimary),
                                                      ),
                                                      onPressed: () {},
                                                      child: Icon(
                                                          Icons.info_outline,
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .inversePrimary),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return Container();
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ),
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
}
