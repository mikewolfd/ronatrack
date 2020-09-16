import 'package:flutter/material.dart';
import 'package:ronatrack/components/common/loading.dart';

class SplashPage extends LoadingIndicator {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/covid-2.png',
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      ),
    );
  }
}
