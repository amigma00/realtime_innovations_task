import 'package:dartz/dartz.dart';
import 'package:realtime_innovations_task/src/core/error/failures.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

import '../sources/add_edit_employee_local_datasource.dart';
import '../../domain/repositories/repositories.dart';

class AddEditEmployeeRepositoryImp implements AddEditEmployeeRepository {
  final AddEditEmployeeLocalDataSource localDataSource;
  AddEditEmployeeRepositoryImp({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> addUser(Employees employee) async {
    try {
      await localDataSource.addEmployee(employee);
      return Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
