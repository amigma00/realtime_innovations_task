import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/pages/add_edit_employee_page.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true, // Enable logging
  initialLocation: '/', // Initial route

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/add-edit-employee',
      builder: (context, state) => BlocProvider(
        create: (context) => AddEditEmployeeCubit(),
        child: AddEditEmployeePage(),
      ),
    ),
  ],
);
