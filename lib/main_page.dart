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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: SvgPicture.asset("assets/svg/logo.svg"),
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
                onPressed: (){},
                child: Text("Мой профиль"),
              ),
              TextButton(
                onPressed: (){},
                child: Text("Добавление сотрудника"),
              ),
              TextButton(
                onPressed: (){},
                child: Text("Изменить сотрудника"),
              ),
            ],
          ),
          //Столбец с Dashboard
          Expanded(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
