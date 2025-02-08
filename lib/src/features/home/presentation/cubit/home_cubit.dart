import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';
import 'package:realtime_innovations_task/src/features/home/domain/usecases/usecases.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeUseCase getUsecase;
  HomeCubit({required this.getUsecase}) : super(HomeInitial());

  void onFabPressed(BuildContext context) async {
    final result = await context.push('/add-edit-employee');
    getEmployees();
    if (result != null) {
      if (result == true) {
        getEmployees();
      } else {
        getEmployees();
      }
    }
  }

  void init() => getEmployees();

  void getEmployees() async {
    //  showLoading(context);
    final result = await getUsecase.getEmployees();
    result.fold(
      (l) => emit(HomeFailed()),
      (r) => emit(HomeLoaded(r)),
    );
  }

  Future<bool> deleteEmployee(int id) async {
    emit(HomeLoading());
    bool isSuccess = false;
    final result = await getUsecase.deleteEmployee(id);
    result.fold(
      (l) => emit(HomeFailed()),
      (r) {
        emit(HomeDeleted(dbId: id));
        isSuccess = true;
      },
    );
    return isSuccess;
  }

  void onEmployeeTap(BuildContext context, Employees employee) {
    context.push('/add-edit-employee', extra: employee);
  }
}
