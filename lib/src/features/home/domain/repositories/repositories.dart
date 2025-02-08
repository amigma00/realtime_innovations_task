import 'package:dartz/dartz.dart';
import 'package:realtime_innovations_task/src/core/error/failures.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

abstract class HomeRepository {
  // Future<User> getUser(String userId);
  Future<Either<Failure, List<Employees>>> getEmployees();
  Future<Either<Failure, bool>> deleteEmployees(int id);
}
