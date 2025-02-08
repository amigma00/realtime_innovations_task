import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_task/src/core/di/service_locator.dart';
import 'package:realtime_innovations_task/src/core/services/custom_bloc_observer.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  setupLocator();
  runApp(MyApp());
}
