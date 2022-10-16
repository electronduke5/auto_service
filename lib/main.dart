import 'package:auto_service/login_page.dart';
import 'package:auto_service/main_page.dart';
import 'package:auto_service/models/user.dart';
import 'package:auto_service/services/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'ColorSchemes/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.interTextTheme()),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.interTextTheme(
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)))),
      //home: const LoginPage(),
      home: RepositoryProvider(
        create: (context) => LoginService(),
        child: LoginPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/MainPage': (BuildContext context) => const MainPage(),
        '/LoginPage': (BuildContext context) =>  LoginPage(),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
