import 'package:get_it/get_it.dart';
import 'package:realtime_innovations_task/src/core/services/isar_service.dart';

import 'package:realtime_innovations_task/src/features/add_edit_employee/data/implements/add_edit_employee_repository_imp.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/data/sources/add_edit_employee_local_datasource.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/domain/repositories/repositories.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/domain/usecases/usecases.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:realtime_innovations_task/src/features/home/data/implements/home_repository_imp.dart';
import 'package:realtime_innovations_task/src/features/home/data/sources/home_local_datasource.dart';
import 'package:realtime_innovations_task/src/features/home/domain/repositories/repositories.dart';
import 'package:realtime_innovations_task/src/features/home/domain/usecases/usecases.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
//initialization
  final isar = await IsarService.init();

//others
  sl.registerLazySingleton<IsarDatabase>(() => IsarDatabase(isar));

//DatSources
  sl.registerLazySingleton<AddEditEmployeeLocalDataSource>(
    () => AddEditEmployeeLocalDataSource(),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSource(),
  );

  //Repositories
  sl.registerLazySingleton<AddEditEmployeeRepository>(
    () => AddEditEmployeeRepositoryImp(
        localDataSource: sl<AddEditEmployeeLocalDataSource>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImp(localDataSource: sl<HomeLocalDataSource>()),
  );

  //Usecases
  sl.registerLazySingleton<GetAddEditEmployeeUseCase>(
    () =>
        GetAddEditEmployeeUseCase(repository: sl<AddEditEmployeeRepository>()),
  );
  sl.registerLazySingleton<GetHomeUseCase>(
    () => GetHomeUseCase(repository: sl<HomeRepository>()),
  );

  //Cubits
  sl.registerFactory<AddEditEmployeeCubit>(
    () => AddEditEmployeeCubit(getUsecase: sl<GetAddEditEmployeeUseCase>()),
  );
  sl.registerLazySingleton<HomeCubit>(
    () => HomeCubit(getUsecase: sl<GetHomeUseCase>()),
  );
}
