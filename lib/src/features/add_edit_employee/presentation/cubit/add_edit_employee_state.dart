part of 'add_edit_employee_cubit.dart';

@immutable
abstract class AddEditEmployeeState {}

class AddEditEmployeeInitial extends AddEditEmployeeState {}

class AddEditEmployeeLoading extends AddEditEmployeeState {}

class AddEditEmployeeAdded extends AddEditEmployeeState {}

class AddEditEmployeeFailed extends AddEditEmployeeState {}
