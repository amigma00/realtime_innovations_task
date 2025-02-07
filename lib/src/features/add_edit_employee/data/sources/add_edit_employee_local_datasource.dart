import 'package:isar/isar.dart';
import 'package:realtime_innovations_task/src/core/di/service_locator.dart';
import 'package:realtime_innovations_task/src/core/services/isar_service.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

class AddEditEmployeeLocalDataSource {
  // Make API call to fetch data and return object.
  // ...

  final Isar _isar = sl<IsarDatabase>().instance;

  Future<bool> addUser(Employees employee) async {
    await _isar.writeTxn(
      () async => await _isar.employees.put(employee),
    );
    return true;
  }
}
