import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/widgets/select_date_dialog.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/widgets/select_role_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

part 'add_edit_employee_state.dart';

class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
  AddEditEmployeeCubit() : super(AddEditEmployeeInitial());

  TextEditingController empNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  void onRoleSelected(BuildContext context) async {
    var role = await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) => SelectroleBottomSheet(),
    );
    if (role != null) roleController.text = role;
    print(role);
  }

  void onDateWidgetTapped(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => SelectDateDialog(),
    );
  }
}
