import 'package:isar/isar.dart';
import 'package:realtime_innovations_task/src/core/di/service_locator.dart';
import 'package:realtime_innovations_task/src/core/services/isar_service.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

class HomeLocalDataSource {
  // Make API call to fetch data and return object.
  // ...

  final Isar _isar = sl<IsarDatabase>().instance;

  Future<List<Employees>> getEmployees() async =>
      await _isar.employees.where().findAll();

  Future<bool> deleteEmployees(int id) async =>
      await _isar.writeTxn<bool>(() async => await _isar.employees.delete(id));
}
