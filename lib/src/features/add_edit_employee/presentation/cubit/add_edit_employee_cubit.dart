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
  Employees? employee;
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
    await showDialog<DateTime>(
      barrierDismissible: false,
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
          if (value == null) {
            return;
          } else if (value.isAfter(startDate)) {
            endDate = value;
            endDateController.text =
                SelectDateDialogHelper.getFormattedDate(endDate);
          } else {
            const snackBar = SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text("End date can't be before Start date"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
    );
  }

  void onSaveTapped() async {
    if (formKey.currentState!.validate()) {
      var emp = Employees(
        endDate: endDate,
        name: empNameController.text,
        role: roleController.text,
        startDate: startDate,
      );
      if (employee != null) {
        emp.dbId = employee!.dbId;
      }
      // emit(AddEditEmployeeLoading());
      final result = await getUsecase.addEmployee(emp);
      result.fold(
        (l) {
          emit(AddEditEmployeeFailed());
        },
        (r) {
          if (employee == null) {
            emit(AddEditEmployeeAdded());
          } else {
            emit(AddEditEmployeeEditted());
          }
        },
      );
    }
  }

  void init(Employees? emp) {
    employee = emp;
    if (employee == null) {
      startDate = DateTime.now();
      startDateController.text = 'Today';
    } else {
      setEmployee();
    }
  }

  setEmployee() {
    empNameController.text = employee?.name ?? '';
    roleController.text = employee?.role ?? '';
    startDate = employee?.startDate ?? DateTime.now();
    if (endDate != null) endDate = employee?.endDate;
    startDateController.text =
        SelectDateDialogHelper.getFormattedDate(startDate);
    endDateController.text = SelectDateDialogHelper.getFormattedDate(endDate);
  }

  @override
  Future<void> close() {
    // TODO: implement close

    empNameController.dispose();
    roleController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    return super.close();
  }
}
