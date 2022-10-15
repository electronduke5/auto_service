import 'dart:ui';

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/autoservice.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Card(
                elevation: 5,
                shadowColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      color: Theme.of(context).hintColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Добро пожаловать\n в систему!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Material(
                            elevation: 15,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            shadowColor: Theme.of(context).primaryColor,
                            child: TextFormField(
                              controller: _loginController,
                              expands: false,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_box),
                                border: OutlineInputBorder(),
                                labelText: "Логин",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 40),
                          child: Material(
                            elevation: 15,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            shadowColor: Theme.of(context).primaryColor,
                            child: TextFormField(
                              maxLines: 1,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.security),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25),
                        child: Text(
                          'Войти',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
