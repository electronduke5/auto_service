import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';
import 'package:auto_service/blocs/categories/categories_bloc.dart';
import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/purchasing_nav_bloc/purchasing_nav_bloc.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/data/dto/autoparts_dto.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/presentation/widgets/autoparts_widgets/add_autopart_card.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAutopartPage extends StatelessWidget {
  const AddAutopartPage({Key? key, required this.width, this.autopart})
      : super(key: key);
  final AutopartDto? autopart;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: width / 2),
      child: BlocListener<AutopartBloc, AutopartState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormSubmissionFailed) {
            SnackBarInfo.show(
              context: context,
              message: formStatus.exception.toString(),
              isSuccess: false,
            );
          } else if (formStatus is FormSubmissionSuccess<AutopartDto>) {
            SnackBarInfo.show(
              context: context,
              message: 'Запчасть успешно заказана2!',
              isSuccess: true,
            );
            switch(autopart){
              case null:
                context
                    .read<PurchasingNavBloc>()
                    .add(ToViewAutopartsPageEvent());
                break;

              default:
                context
                    .read<StorekeeperNavBloc>()
                    .add(ToViewAutopartsEvent());
                break;
            }
            context.read<AutopartBloc>().add(GetListAutopartsEvent());
          }
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: state.modelsStatus is SubmissionSuccess<CategoryDto>
                    ? AddAutopartCard(
                        autopart: autopart,
                        width: width,
                        menuItems:
                            state.modelsStatus.entities as List<CategoryDto>)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ));
          },
        ),
      ),
    );
  }
}
