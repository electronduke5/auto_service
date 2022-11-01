import 'package:auto_service/blocs/form_submission_status.dart';
import 'package:auto_service/blocs/login_bloc/login_bloc.dart';
import 'package:auto_service/services/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
        if (formStatus is SubmissionFailed) {
          _showShackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          //Navigator.push(context, '/MainPage', MaterialPageRoute(builder: (context) => ))
          Navigator.of(context).pushReplacementNamed('/MainPage', arguments: formStatus.entity);
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
                          "Добро пожаловать\n в систему!",
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
                    'Войти',
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
                  state.isValidPassword ? null : 'Это обязательное поле',
              onChanged: (value) => context.read<LoginBloc>().add(
                    PasswordChanged(value),
                  ),
              maxLines: 1,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.security),
                border: OutlineInputBorder(),
                labelText: "Пароль",
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
                    state.isValidLogin ? null : 'Это обязательное поле',
                onChanged: (value) =>
                    context.read<LoginBloc>().add(LoginChanged(value)),
                expands: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.account_box),
                  fillColor: state.formStatus is SubmissionFailed
                      ? Colors.red
                      : Colors.green,
                  border: const OutlineInputBorder(),
                  labelText: "Логин",
                ),
              )),
        );
      },
    );
  }

  void _showShackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).errorColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
