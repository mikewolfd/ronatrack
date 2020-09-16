import 'package:ronatrack/repo/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronatrack/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:ronatrack/style/color_utils.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: BlocProvider(
            create: (_) => LoginCubit(
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
                    LoginForm(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
