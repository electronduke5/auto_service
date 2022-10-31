import 'package:auto_service/login_page.dart';
import 'package:auto_service/main_page.dart';
import 'package:auto_service/services/get_employees.dart';
import 'package:auto_service/services/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ColorSchemes/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}
//TODO: почитать про MultyProviders

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.interTextTheme()),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: const Color.fromRGBO(0, 26, 51, 1),
          textTheme: GoogleFonts.interTextTheme(
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)))),
      //home: const LoginPage(),
      home: RepositoryProvider(
        create: (context) => LoginService(),
        child: LoginPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/MainPage': (context) => RepositoryProvider(
              create: (context) => GetEmployeesService(),
              child: MainPage(),
            ),
        '/LoginPage': (context) => RepositoryProvider(
              create: (context) => LoginService(),
              child: LoginPage(),
            ),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
