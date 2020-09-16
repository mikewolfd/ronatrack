import 'package:ronatrack/repo/auth.dart';
import 'package:ronatrack/repo/user.dart';
import 'app.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ronatrack/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(App(
    authenticationRepository:
        AuthenticationRepository(userRepository: UserRepository()),
  ));
}
