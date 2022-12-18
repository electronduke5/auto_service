import 'package:auto_service/blocs/accountants/accountant_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/accountant_nav_bloc/accountant_nav_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/accountant_widgets/accountant_cards.dart';
import 'package:auto_service/presentation/widgets/actions_card.dart';
import 'package:auto_service/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantPage extends StatelessWidget {
  const AccountantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 2.5;
    final loggedEmployee =
        ModalRoute.of(context)!.settings.arguments as EmployeeDto;
    return Scaffold(
      appBar: AppBarWidget(context: context, loggedEmployee: loggedEmployee),
      body:
          _buildAccountantBody(context, cardWidth, cardHeight, loggedEmployee),
    );
  }

  List<Widget> widgets(BuildContext context) => [
        ElevatedButton.icon(
          icon: const Icon(Icons.group_outlined),
          onPressed: () {
            context.read<AccountantNavBloc>().add(ToViewAllEvent());
            context.read<AccountantBloc>().add(GetAllListEvent());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Все расходы и доходы",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.person_add_alt),
          onPressed: () {
            //context.read<HrNavigationBloc>().add(ToAddEmployeePage());
          },
          style: ElevatedButton.styleFrom(elevation: 7),
          label: const Text(
            "Что-то еще надо",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ];

  Widget _buildAccountantBody(BuildContext context, double cardWidth,
      double cardHeight, EmployeeDto loggedEmployee) {
    return Row(
      children: [
        //Столбец с действиями
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
          child: MainActionsCard(children: [...widgets(context)]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: BlocBuilder<AccountantNavBloc, AccountantNavState>(
              builder: (context, state){
                switch(state.runtimeType){
                  case AccountantInViewAllState:
                    return AccountantCards(width: cardWidth, height: cardHeight);
                  default:
                    return const Center(
                      child: Text('Что-то не работает'),
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
