import 'package:dartz/dartz.dart';
import 'package:realtime_innovations_task/src/core/error/failures.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

import '../repositories/repositories.dart';

class GetHomeUseCase {
  final HomeRepository repository;

  GetHomeUseCase({required this.repository});

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }
  Future<Either<Failure, List<Employees>>> getEmployees() async =>
      repository.getEmployees();

  Future<Either<Failure, void>> deleteEmployee(int id) async =>
      repository.deleteEmployees(id);
}
