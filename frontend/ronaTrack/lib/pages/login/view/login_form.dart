import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronatrack/pages/login/login.dart';
import 'package:ronatrack/pages/signup/views/views.dart';
import 'package:ronatrack/style/color_utils.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 8,
              child: Column(
                children: <Widget>[
                  _buildIntroText(),
                  const Padding(padding: EdgeInsets.all(12)),
                  _UsernameInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  _PasswordInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  _LoginButton(),
                  const SizedBox(height: 4.0),
                  _SignUpButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildIntroText() {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(children: [
          Text(
            "Login",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ]),
      )
    ],
  );
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) =>
                  context.bloc<LoginCubit>().usernameChanged(username),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'username',
                helperText: '',
                errorText: state.username.invalid ? 'invalid username' : null,
              ),
            ));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.bloc<LoginCubit>().passwordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
                helperText: '',
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            ));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    width: double.infinity,
                    child: RaisedButton(
                      color: ColorUtils.primaryColor,
                      disabledColor: ColorUtils.primaryColor,
                      key: const Key('loginForm_continue_raisedButton'),
                      child: const Text('Login'),
                      onPressed: state.status.isValidated
                          ? () =>
                              context.bloc<LoginCubit>().logInWithCredentials()
                          : null,
                    )));
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FlatButton(
      key: const Key('loginForm_createAccount_flatButton'),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );
  }
}
