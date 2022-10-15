import 'package:auto_service/ColorSchemes/color_schemes.g.dart';
import 'package:auto_service/models/user.dart';
import 'package:auto_service/services/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'interfaces/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginService _loginService = LoginService();
    final _loginController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(50),
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.asset("assets/svg/login.png"),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset("assets/svg/logo.svg"),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text(
                              textAlign: TextAlign.left,
                              "Добро пожаловать \nв систему!",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 250,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Material(
                                  elevation: 15,
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  shadowColor: Theme.of(context).primaryColor,
                                  child: TextFormField(
                                    controller: _loginController,
                                    expands: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Логин",
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 250,
                                margin:
                                const EdgeInsets.symmetric(horizontal: 40 ,vertical: 40),
                                child: Material(
                                  elevation: 15,
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  shadowColor: Theme.of(context).primaryColor,
                                  child: TextFormField(

                                    maxLines: 1,
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Пароль",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // UserModel? user = await _loginService.login(_loginController.text, _passwordController.text);
                              // if(user!= null){
                              //   Navigator.pushNamed(
                              //       context, '/MainPage',arguments: user);
                              // }
                              // else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content: Text(
                              //             "Ошибка при получении данных пользователя")),
                              //   );
                              // }

                              Navigator.pushNamed(context, '/MainPage');
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Войти',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
