import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/domain/usecases/usecases.dart';

import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/helper/select_date_dialog_helper.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/widgets/select_date_dialog.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/widgets/select_role_bottom_sheet.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';

part 'add_edit_employee_state.dart';

class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
  final GetAddEditEmployeeUseCase getUsecase;

  AddEditEmployeeCubit({required this.getUsecase})
      : super(AddEditEmployeeInitial());

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController empNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  late DateTime startDate;
  DateTime? endDate;

  void onRoleSelected(BuildContext context) async {
    var role = await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) => SelectroleBottomSheet(),
    );
    if (role != null) roleController.text = role;
  }

  void onDateWidgetTapped(BuildContext context,
      {required bool isStartDate}) async {
    await showDialog(
      context: context,
      builder: (context) => SelectDateDialog(isStartDate: isStartDate),
    ).then(
      (value) {
        if (isStartDate) {
          if (value != null) {
            startDate = value;
            startDateController.text =
                SelectDateDialogHelper.getFormattedDate(startDate);
          }
        } else {
          endDate = value;
        }
      },
    );
  }

  void onSaveTapped() async {
    if (formKey.currentState!.validate()) {
      var employee = Employees(
        endDate: endDate.toString(),
        name: empNameController.text,
        role: roleController.text,
        startDate: startDate.toString(),
      );
      emit(AddEditEmployeeLoading());
      final result = await getUsecase.addEmployee(employee);
      result.fold(
        (l) {
          
          emit(AddEditEmployeeFailed());
        },
        (r) {
          
          emit(AddEditEmployeeAdded());
        },
      );
    }
  }

  void init() {
    startDate = DateTime.now();
    startDateController.text = 'Today';
  }
}
