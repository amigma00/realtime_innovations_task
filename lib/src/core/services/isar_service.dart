import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

class IsarService {
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [EmployeesSchema],
      directory: dir.path,
    );
    return isar;
  }
}

class IsarDatabase {
  final Isar _isar;

  IsarDatabase(this._isar);

  Isar get instance => _isar;
}
