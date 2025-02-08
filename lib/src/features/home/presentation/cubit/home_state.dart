part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Employees> employees;

  HomeLoaded(this.employees);
}

class HomeDeleted extends HomeState {
  final int dbId;

  HomeDeleted({required this.dbId});
}

class HomeFailed extends HomeState {}
