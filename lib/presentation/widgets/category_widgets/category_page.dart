import 'package:auto_service/blocs/categories/categories_bloc.dart';
import 'package:auto_service/blocs/get_models_status.dart';
import 'package:auto_service/blocs/navigations_bloc/storekeeper_nav_bloc/storekeeper_nav_bloc.dart';
import 'package:auto_service/data/dto/category_dto.dart';
import 'package:auto_service/presentation/widgets/category_widgets/category_alert_dialogs.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryViewPage extends StatelessWidget {
  const CategoryViewPage({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              switch (state.modelsStatus.runtimeType) {
                case Submitting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case InitialModelsStatus:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case SubmissionSuccess<CategoryDto>:
                  return _categoryGridView(state, width, context);

                case SubmissionFailed:
                  {
                    return Center(
                      child:
                      Text(state.modelsStatus.error ?? 'Submission Failed'),
                    );
                  }
                default:
                  return const Center(
                    child: Text("Непредвиденная ошибка"),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _categoryGridView(CategoryState state, double width,
      BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, stateDelete) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return _categoryViewCard(
                context: context,
                category:
                (state.modelsStatus.entities as List<CategoryDto>)[index]);
          },
          itemCount: (state.modelsStatus.entities as List<CategoryDto>).length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 10,
            childAspectRatio: width / width * 1.4,
            maxCrossAxisExtent: MediaQuery
                .of(context)
                .size
                .width * 0.2,
          ),
        );
      },
    );
  }
  Widget _categoryViewCard(
      {required BuildContext context, required CategoryDto category}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Категория "${category.name!}"',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                // Text(
                //   "Количество авто: ${client.cars!.length}",
                //   style: TextStyle(color: Theme.of(context).hintColor),
                // ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                      ),
                      onPressed: () {
                        context
                            .read<CategoryBloc>()
                            .add(EditFormCategoryInitialEvent(category));
                        CategoryDialogs.openDialog(context: context, bloc: context.read<CategoryBloc>(), category: category, navBloc: context.read<StorekeeperNavBloc>());
                      },
                      child: const Icon(Icons.edit, color: Colors.amber),
                    ),
                    SizedBox(width: width * 0.01),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).errorColor),
                      ),
                      onPressed: () {
                        context
                            .read<CategoryBloc>()
                            .add(DeleteCategoryEvent(category.id!));
                        SnackBarInfo.show(
                            context: context,
                            message:
                            'Категория ${category.name}  успешно удалена!',
                            isSuccess: true);

                        context.read<CategoryBloc>().add(GetListCategoriesEvent());
                      },
                      child: Icon(Icons.delete_outlined,
                          color: Theme.of(context).errorColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
