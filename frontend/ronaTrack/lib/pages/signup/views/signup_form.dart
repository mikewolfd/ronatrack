import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronatrack/pages/signup/cubit/signup_cubit.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Sign Up Failure')),
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
                    const Padding(padding: EdgeInsets.all(6)),
                    _EmailInput(),
                    const Padding(padding: EdgeInsets.all(6)),
                    _UsernameInput(),
                    const Padding(padding: EdgeInsets.all(6)),
                    _PasswordInput(),
                    const Padding(padding: EdgeInsets.all(6)),
                    _SignUpButton(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget _buildIntroText() {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(children: [
          Text(
            "Register",
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) =>
                  context.bloc<SignUpCubit>().usernameChanged(username),
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: TextField(
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (email) =>
                  context.bloc<SignUpCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'email',
                helperText: '',
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            ));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.bloc<SignUpCubit>().passwordChanged(password),
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                      key: const Key('signUpForm_continue_raisedButton'),
                      child: const Text('SIGN UP'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.orangeAccent,
                      onPressed: state.status.isValidated
                          ? () =>
                              context.bloc<SignUpCubit>().signUpFormSubmitted()
                          : null,
                    )));
      },
    );
  }
}
