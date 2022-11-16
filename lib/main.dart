import 'package:auto_service/blocs/autoparts/view_autoparts/view_autoparts_bloc.dart';
import 'package:auto_service/blocs/delete_employee_bloc/delete_employee_bloc.dart';
import 'package:auto_service/blocs/employee_bloc/employee_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/purchasing_nav_bloc/purchasing_nav_bloc.dart';
import 'package:auto_service/presentation/pages/hr_page.dart';
import 'package:auto_service/presentation/pages/login_page.dart';
import 'package:auto_service/services/autoparts_service.dart';
import 'package:auto_service/services/employee_service.dart';
import 'package:auto_service/services/get_employees.dart';
import 'package:auto_service/services/login.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ColorSchemes/color_schemes.g.dart';
import 'blocs/get_employees_bloc/get_employees_bloc.dart';
import 'presentation/pages/purchasing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DesktopWindow.setMinWindowSize(const Size(1920 / 1.1, 1080 / 1.5));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          scaffoldBackgroundColor: const Color.fromRGBO(234, 237, 242, 1),
          textTheme: GoogleFonts.interTextTheme()),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: const Color.fromRGBO(0, 26, 51, 1),
          textTheme: GoogleFonts.interTextTheme(
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)))),
      home: RepositoryProvider(
        create: (context) => LoginService(),
        child: LoginPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/PurchasingPage': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<PurchasingNavBloc>(
                  create: (context) => PurchasingNavBloc(),
                ),
                BlocProvider<ViewAutopartsBloc>(
                  create: (context) =>
                      ViewAutopartsBloc(autopartsService: AutopartsService())
                        ..add(GetListAutopartsEvent()),
                ),
              ],
              child: const PurchasingPage(),
            ),
        '/MainPage': (context) => MultiBlocProvider(providers: [
              BlocProvider<HrNavigationBloc>(
                create: (context) => HrNavigationBloc(),
              ),
              BlocProvider<GetEmployeesBloc>(
                create: (context) =>
                    GetEmployeesBloc(getEmployeesService: GetEmployeesService())
                      ..add(GetListEmployeesEvent()),
              ),
              BlocProvider<EmployeeBloc>(
                create: (context) =>
                    EmployeeBloc(addEmployeeService: EmployeeService()),
              ),
              BlocProvider<DeleteEmployeeBloc>(
                  create: (context) =>
                      DeleteEmployeeBloc(employeeService: EmployeeService())),
            ], child: const MainPage()),
        '/LoginPage': (context) => RepositoryProvider(
              create: (context) => LoginService(),
              child: LoginPage(),
            ),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
