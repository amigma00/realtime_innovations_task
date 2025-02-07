import 'package:get_it/get_it.dart';
import 'package:realtime_innovations_task/src/core/services/isar_service.dart';

import 'package:realtime_innovations_task/src/features/add_edit_employee/data/implements/add_edit_employee_repository_imp.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/data/sources/add_edit_employee_local_datasource.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/domain/repositories/repositories.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/domain/usecases/usecases.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';

final sl = GetIt.instance;

void setupLocator() async {
  final isar = await IsarService.init();
//others
  sl.registerLazySingleton<IsarDatabase>(() => IsarDatabase(isar));
//DatSources
  sl.registerLazySingleton<AddEditEmployeeLocalDataSource>(
    () => AddEditEmployeeLocalDataSource(),
  );

  //Repositories
  sl.registerLazySingleton<AddEditEmployeeRepository>(
    () => AddEditEmployeeRepositoryImp(
        localDataSource: sl<AddEditEmployeeLocalDataSource>()),
  );

  //Usecases
  sl.registerLazySingleton<GetAddEditEmployeeUseCase>(
    () =>
        GetAddEditEmployeeUseCase(repository: sl<AddEditEmployeeRepository>()),
  );

  //Cubits
  sl.registerLazySingleton<AddEditEmployeeCubit>(
    () => AddEditEmployeeCubit(getUsecase: sl<GetAddEditEmployeeUseCase>()),
  );
}
