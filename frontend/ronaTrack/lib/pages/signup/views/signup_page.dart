import 'package:ronatrack/repo/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronatrack/pages/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ronatrack/style/color_utils.dart';

import 'signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          backgroundColor: ColorUtils.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: BlocProvider<SignUpCubit>(
              create: (_) => SignUpCubit(
                context.repository<AuthenticationRepository>(),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.70,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(gradient: ColorUtils.appBarGradient),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Text(
                          "ronaTrack",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 30),
                        ),
                      )),
                  Positioned(
                    top: 140,
                    left: 10,
                    right: 10,
                    child: Column(children: <Widget>[
                      _buildLogo(),
                      SignUpForm(),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Image.asset(
        "images/covid-2.png",
        height: 125,
        width: 125,
      ),
    );
  }
}
