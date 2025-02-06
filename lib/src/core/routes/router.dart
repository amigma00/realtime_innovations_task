import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/pages/add_edit_employee_page.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/pages/home_page.dart';

class AppRouter {
  // GoRouter configuration
  static final router = GoRouter(
    debugLogDiagnostics: true, // Enable logging
    initialLocation: '/', // Initial route

    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        name: 'add-edit-employee',
        path: '/add-edit-employee',
        builder: (context, state) => BlocProvider(
          create: (context) => AddEditEmployeeCubit(),
          child: AddEditEmployeePage(),
        ),
      ),
    ],
  );
}
