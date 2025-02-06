import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realtime_innovations_task/gen/assets.gen.dart';
import 'package:realtime_innovations_task/src/components/realinnov_text_field.dart';
import 'package:realtime_innovations_task/src/core/extension/padding_extension.dart';
import 'package:realtime_innovations_task/src/core/extension/sizebox_extension.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';

class AddEditEmployeePage extends StatelessWidget {
  const AddEditEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditEmployeeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee Details'),
      ),
      body: Column(
        children: [
          24.kheightBox,
          RealInnovTexTField(
            prefix: SvgPicture.asset(
              Assets.svgs.employeeIcon.path,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
            controller: cubit.textController,
            hintText: 'Employee name',
          ),
          24.kheightBox,
          RealInnovTexTField(
            prefix: SvgPicture.asset(
              Assets.svgs.jobRole.path,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
            controller: cubit.textController,
            hintText: 'Select role',
          ),
          24.kheightBox,
          Row(
            children: [
              Expanded(
                child: RealInnovTexTField(
                  prefix: SvgPicture.asset(
                    Assets.svgs.calendar.path,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                  controller: cubit.textController,
                  hintText: 'No date',
                ),
              ),
              Assets.svgs.arrowRight.svg().paddingSymmetric(horizontal: 16),
              Expanded(
                child: RealInnovTexTField(
                  prefix: SvgPicture.asset(
                    Assets.svgs.calendar.path,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                  controller: cubit.textController,
                  hintText: 'No date',
                ),
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
