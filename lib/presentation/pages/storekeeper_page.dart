import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/categories/categories_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/blocs/service_bloc/service_bloc.dart';
import 'package:auto_service/blocs/service_type_bloc/type_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/data/dto/service_type_dto.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/add_autopart_page.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/autoparts_cards.dart';
import 'package:auto_service/presentation/widgets/category_widgets/category_alert_dialogs.dart';
import 'package:auto_service/presentation/widgets/category_widgets/category_page.dart';
import 'package:auto_service/presentation/widgets/service_type_widgets/service_type_alert_dialogs.dart';
import 'package:auto_service/presentation/widgets/service_type_widgets/type_page.dart';
import 'package:auto_service/presentation/widgets/service_widgets/service_alert_dialog.dart';
import 'package:auto_service/presentation/widgets/service_widgets/service_page.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorekeeperPage extends StatelessWidget {
  const StorekeeperPage({Key? key}) : super(key: key);

  List<Widget> widgets(BuildContext context) => [
        ElevatedButton.icon(
          icon: const Icon(Icons.list_alt_outlined),
          onPressed: () {
            context.read<StorekeeperNavBloc>().add(ToViewAutopartsEvent());
            context.read<AutopartBloc>().add(GetListAutopartsEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Все запчасти",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.category),
          onPressed: () {
            context.read<StorekeeperNavBloc>().add(ToViewCategoriesEvent());
            context.read<CategoryBloc>().add(GetListCategoriesEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Категории",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.category),
          onPressed: () {
            CategoryDialogs.openDialog(
                context: context,
                bloc: context.read<CategoryBloc>(),
                navBloc: context.read<StorekeeperNavBloc>());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "+ Категория",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.car_repair_rounded),
          onPressed: () {
            context.read<StorekeeperNavBloc>().add(ToViewTypesEvent());
            context.read<TypeBloc>().add(GetListTypesEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Виды работ",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.car_repair_rounded),
          onPressed: () {
            TypeDialogs.openDialog(
                context: context,
                bloc: context.read<TypeBloc>(),
                navBloc: context.read<StorekeeperNavBloc>());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "+ Вид работ",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.car_repair_rounded),
          onPressed: () {
            context.read<StorekeeperNavBloc>().add(ToViewServicesEvent());
            context.read<ServiceBloc>().add(GetListServicesEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Работы",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<TypeBloc, TypeState>(
          builder: (context, state) {
            return ElevatedButton.icon(
              icon: const Icon(Icons.car_repair_rounded),
              onPressed: () {
                context.read<TypeBloc>().add(GetListTypesEvent());
                if (state.modelsStatus is SubmissionSuccess<ServiceTypeDto>) {
                  ServiceDialogs.openDialog(
                      menuItems:
                          state.modelsStatus.entities as List<ServiceTypeDto>,
                      context: context,
                      bloc: context.read<ServiceBloc>(),
                      navBloc: context.read<StorekeeperNavBloc>());
                }
              },
              style: ElevatedButton.styleFrom(elevation: 7),
              label: const Text(
                "+ Работа",
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    final loggedEmployee =
        ModalRoute.of(context)!.settings.arguments as EmployeeDto;

    return Scaffold(
      appBar: AppBarWidget(context: context, loggedEmployee: loggedEmployee),
      body: _buildStorekeeperBody(context, cardWidth, loggedEmployee),
    );
  }

  Widget _buildStorekeeperBody(
      BuildContext context, double cardWidth, EmployeeDto loggedEmployee) {
    return BlocListener<AutopartBloc, AutopartState>(
      listener: (context, state) {
        if (state.modelsStatus is SubmissionFailed) {
          SnackBarInfo.show(
              context: context,
              message: state.modelsStatus.error.toString(),
              isSuccess: false);
        }
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
            child: MainActionsCard(
              children: [...widgets(context)],
            ),
          ),
          Expanded(
            child: BlocBuilder<StorekeeperNavBloc, StorekeeperNavState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case StorekeeperInViewCategoriesState:
                    return CategoryViewPage(width: cardWidth);
                  case StorekeeperInViewServicesState:
                    return ServicesViewPage(width: cardWidth);
                  case StorekeeperInViewTypesState:
                    return TypesViewPage(width: cardWidth);
                  case StorekeeperInViewState:
                    return AutopartsCards(
                        context: context, loggedEmployee: loggedEmployee);
                  case StorekeeperInEditState:
                    return AddAutopartPage(
                        width: cardWidth, autopart: state.autopartEdit!);
                  default:
                    return const Center(
                      child: Text('Что-то не работает'),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
