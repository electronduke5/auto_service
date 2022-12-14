import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/login_bloc/login_bloc.dart';
import 'package:auto_service/data/dto/employee_dto.dart';
import 'package:auto_service/presentation/widgets/snack_bar.dart';
import 'package:auto_service/services/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            LoginBloc(loginService: context.read<LoginService>()),
        child: buildLoginForm(context),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is FormSubmissionFailed) {
          SnackBarInfo.show(
              context: context,
              message: formStatus.exception.toString(),
              isSuccess: false);
        } else if (formStatus is FormSubmissionSuccess) {
          print(formStatus.entity.role);
          switch (RoleEnum.values
              .firstWhere((role) => role.name == formStatus.entity.role)) {
            case RoleEnum.hr:
              Navigator.of(context).pushReplacementNamed('/MainPage',
                  arguments: formStatus.entity);
              break;
            case RoleEnum.purchasing:
              Navigator.of(context).pushReplacementNamed('/PurchasingPage',
                  arguments: formStatus.entity);
              break;
            case RoleEnum.clientManager:
              Navigator.of(context).pushReplacementNamed('/ReceiverPage',
                  arguments: formStatus.entity);
              break;
            case RoleEnum.accountant:
              Navigator.of(context).pushReplacementNamed('/AccountantPage',
                  arguments: formStatus.entity);
              break;
            case RoleEnum.storekeeper:
              Navigator.of(context).pushReplacementNamed('/StorekeeperPage',
                  arguments: formStatus.entity);
              break;
          }
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
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
                          "?????????? ????????????????????\n ?? ??????????????!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          _loginField(context),
                          _passwordField(context),
                        ],
                      ),
                      _loginButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<LoginBloc>()
                        .add(LoginSubmitted(state.login, state.password));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
                  child: Text(
                    '??????????',
                  ),
                ),
              );
      },
    );
  }

  Widget _passwordField(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Material(
        elevation: 15,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        shadowColor: Theme.of(context).primaryColor,
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return TextFormField(
              validator: (value) =>
                  state.isValidPassword ? null : '?????? ???????????????????????? ????????',
              onChanged: (value) => context.read<LoginBloc>().add(
                    PasswordChanged(value),
                  ),
              maxLines: 1,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.security),
                border: OutlineInputBorder(),
                labelText: "????????????",
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _loginField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          height: 50,
          width: 250,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Material(
            elevation: 15,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            shadowColor: Theme.of(context).primaryColor,
            child: TextFormField(
              validator: (value) =>
                  state.isValidLogin ? null : '?????? ???????????????????????? ????????',
              onChanged: (value) =>
                  context.read<LoginBloc>().add(LoginChanged(value)),
              expands: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_box),
                fillColor: state.formStatus is FormSubmissionFailed
                    ? Colors.red
                    : Colors.green,
                border: const OutlineInputBorder(),
                labelText: "??????????",
              ),
            ),
          ),
        );
      },
    );
  }
}
