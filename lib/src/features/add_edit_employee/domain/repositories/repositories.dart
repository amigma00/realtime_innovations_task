import 'package:dartz/dartz.dart';
import 'package:realtime_innovations_task/src/core/error/failures.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

abstract class AddEditEmployeeRepository {
  // Future<User> getUser(String userId);

  Future<Either<Failure, bool>> addUser(Employees employee);
}
