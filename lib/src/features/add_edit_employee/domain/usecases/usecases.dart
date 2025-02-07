import 'package:dartz/dartz.dart';
import 'package:realtime_innovations_task/src/core/error/failures.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

import '../repositories/repositories.dart';

class GetAddEditEmployeeUseCase {
  final AddEditEmployeeRepository repository;

  GetAddEditEmployeeUseCase({required this.repository});

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }

  Future<Either<Failure, bool>> addEmployee(Employees employee) async =>
      repository.addUser(employee);
}
