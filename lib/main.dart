import 'package:auto_service/blocs/accountants/accountant_bloc.dart';
import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/cars/car_bloc.dart';
import 'package:auto_service/blocs/categories/categories_bloc.dart';
import 'package:auto_service/blocs/clients/client_bloc.dart';
import 'package:auto_service/blocs/delete_employee_bloc/delete_employee_bloc.dart';
import 'package:auto_service/blocs/employee_bloc/employee_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/accountant_nav_bloc/accountant_nav_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/hr_navigation_bloc/hr_navigation_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/purchasing_nav_bloc/purchasing_nav_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/receiver_nav_bloc/receiver_nav_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/blocs/orders_bloc/order_bloc.dart';
import 'package:auto_service/blocs/service_bloc/service_bloc.dart';
import 'package:auto_service/blocs/service_type_bloc/type_bloc.dart';
import 'package:auto_service/presentation/color_schemes/color_schemes.g.dart';
import 'package:auto_service/presentation/pages/accountant_page.dart';
import 'package:auto_service/presentation/pages/hr_page.dart';
import 'package:auto_service/presentation/pages/login_page.dart';
import 'package:auto_service/presentation/pages/receiver_page.dart';
import 'package:auto_service/presentation/pages/storekeeper_page.dart';
import 'package:auto_service/services/accountant_service.dart';
import 'package:auto_service/services/autoparts_service.dart';
import 'package:auto_service/services/car_service.dart';
import 'package:auto_service/services/category_service.dart';
import 'package:auto_service/services/client_service.dart';
import 'package:auto_service/services/employee_service.dart';
import 'package:auto_service/services/login.dart';
import 'package:auto_service/services/order_service.dart';
import 'package:auto_service/services/repair_service.dart';
import 'package:auto_service/services/repair_type_service.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dcdg/dcdg.dart';

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
          textTheme: GoogleFonts.openSansTextTheme(
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)))),
      home: RepositoryProvider(
        create: (context) => LoginService(),
        child: LoginPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/AccountantPage': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<AccountantNavBloc>(
                  create: (context) => AccountantNavBloc(),
                ),
                BlocProvider<AccountantBloc>(
                    create: (context) => AccountantBloc(AccountantService())
                      ..add(GetAllListEvent())),
              ],
              child: const AccountantPage(),
            ),
        '/ReceiverPage': (context) => MultiBlocProvider(providers: [
              BlocProvider<ClientBloc>(
                create: (context) => ClientBloc(clientService: ClientService())
                  ..add(GetListClientEvent()),
              ),
              BlocProvider<ReceiverNavBloc>(
                create: (context) => ReceiverNavBloc(),
              ),
              BlocProvider<CarBloc>(
                create: (context) => CarBloc(carService: CarService()),
              ),
              BlocProvider<OrderBloc>(
                create: (context) => OrderBloc(orderService: OrderService()),
              ),
              BlocProvider<ServiceBloc>(
                create: (context) =>
                    ServiceBloc(repairService: RepairService()),
              ),
              BlocProvider<AutopartBloc>(
                create: (context) =>
                    AutopartBloc(autopartService: AutopartService()),
              ),
            ], child: const ReceiverPage()),
        '/StorekeeperPage': (context) => MultiBlocProvider(providers: [
              BlocProvider<AutopartBloc>(
                create: (context) =>
                    AutopartBloc(autopartService: AutopartService())
                      ..add(GetListAutopartsEvent()),
              ),
              BlocProvider<StorekeeperNavBloc>(
                create: (context) => StorekeeperNavBloc(),
              ),
              BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryService: CategoryService()),
              ),
              BlocProvider<TypeBloc>(
                create: (context) => TypeBloc(typeService: RepairTypeService()),
              ),
              BlocProvider<ServiceBloc>(
                create: (context) =>
                    ServiceBloc(repairService: RepairService()),
              ),
            ], child: const StorekeeperPage()),
        '/PurchasingPage': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<CategoryBloc>(
                  create: (context) =>
                      CategoryBloc(categoryService: CategoryService()),
                ),
                BlocProvider<AutopartBloc>(
                  create: (context) =>
                      AutopartBloc(autopartService: AutopartService())
                        ..add(GetListAutopartsEvent()),
                ),
                BlocProvider<PurchasingNavBloc>(
                  create: (context) => PurchasingNavBloc(),
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
                    GetEmployeesBloc(employeesService: EmployeeService())
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
