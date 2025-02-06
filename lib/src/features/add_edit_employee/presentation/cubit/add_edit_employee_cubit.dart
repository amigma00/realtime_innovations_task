
  import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:meta/meta.dart';

  part 'add_edit_employee_state.dart';
  
  class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
    AddEditEmployeeCubit() : super(AddEditEmployeeInitial());

      final TextEditingController textController = TextEditingController();

  }
  