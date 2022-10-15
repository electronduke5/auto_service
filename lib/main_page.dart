import 'package:auto_service/ColorSchemes/color_schemes.g.dart';
import 'package:auto_service/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    var size = MediaQuery.of(context).size;

    final double itemHeight = size.height / 2;
    final double itemWidth = size.height * 0.8;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: SvgPicture.asset(
          "assets/svg/logo.svg",
          color: Theme.of(context).hintColor,
        ),
        titleSpacing: 12,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                //child: Center(child: Text(user.getFullName())),
                child: Center(child: Text("Иванов Иван")),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          //Столбец с действиями
          Column(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Мой профиль",
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Добавление"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Изменить сотрудника"),
              ),
            ],
          ),
          //Столбец с Dashboard
          Expanded(
            child: Column(
              children: [
                Row(
                  children: const [
                    DropdownButtonExample(),
                  ],
                ),
                Expanded(
                  child: GridView.count(
                      //               width / height children
                      childAspectRatio: itemWidth / itemHeight,
                      padding: const EdgeInsets.all(10),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 4,
                      children: List.generate(25, (int index) {
                        return buildEmployeeCard();
                      })),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildEmployeeCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Иванов Иван Иванович",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text("Должность: HR Менеджер"),
                Text("ЗП: 100000 руб."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const menuItems = <String>[
    'По фамилии',
    'По должности',
    'По размеру зарплаты'
  ];

  final List<DropdownMenuItem<String>> _menuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String? _selectedItem1;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton(
      items: _menuItems,
      value: _selectedItem1,
      hint: const Text('Выберите...'),
      elevation: 4,
      onChanged: (String? value) => setState(() {
        _selectedItem1 = value ?? "";
      }),
    );
    return SizedBox(
      width: 350,
      child: ListTile(
        title: Text('Сортировка:'),
        trailing: dropdown,
      ),
    );
  }
}
