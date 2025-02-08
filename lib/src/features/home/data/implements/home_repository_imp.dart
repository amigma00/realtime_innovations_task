import 'package:dartz/dartz.dart';

import 'package:realtime_innovations_task/src/core/error/failures.dart';

import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

import '../sources/home_local_datasource.dart';
import '../../domain/repositories/repositories.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeLocalDataSource localDataSource;
  HomeRepositoryImp({required this.localDataSource});

  @override
  Future<Either<Failure, List<Employees>>> getEmployees() async {
    try {
      final result = await localDataSource.getEmployees();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEmployees(int id) async {
    try {
      final result = await localDataSource.deleteEmployees(id);

      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
