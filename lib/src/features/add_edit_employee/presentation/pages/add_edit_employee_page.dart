import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/gen/assets.gen.dart';
import 'package:realtime_innovations_task/gen/colors.gen.dart';
import 'package:realtime_innovations_task/src/components/real_innov_button.dart';
import 'package:realtime_innovations_task/src/components/real_innov_text_field.dart';
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
          automaticallyImplyLeading: false,
          title: Text('Add Employee Details'),
        ),
        body: Column(
          children: [
            Column(
              children: [
                24.kheightBox,
                RealInnovTexTField(
                  prefixIcon: SvgPicture.asset(
                    Assets.svgs.employeeIcon.path,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                  controller: cubit.empNameController,
                  hintText: 'Employee name',
                ),
                24.kheightBox,
                RealInnovTexTField(
                  onTap: () => cubit.onRoleSelected(context),
                  readOnly: true,
                  prefixIcon: SvgPicture.asset(
                    Assets.svgs.jobRole.path,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                  suffixIcon: SvgPicture.asset(
                    Assets.svgs.arrowDropDown.path,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                  controller: cubit.roleController,
                  hintText: 'Select role',
                ),
                24.kheightBox,
                Row(
                  children: [
                    Expanded(
                      child: RealInnovTexTField(
                        onTap: () => cubit.onDateWidgetTapped(context),
                        readOnly: true,
                        prefixIcon: SvgPicture.asset(
                          Assets.svgs.calendar.path,
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                        controller: cubit.startDateController,
                        hintText: 'No date',
                      ),
                    ),
                    Assets.svgs.arrowRight
                        .svg()
                        .paddingSymmetric(horizontal: 16),
                    Expanded(
                      child: RealInnovTexTField(
                        onTap: () => cubit.onDateWidgetTapped(context),
                        readOnly: true,
                        prefixIcon: SvgPicture.asset(
                          Assets.svgs.calendar.path,
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                        controller: cubit.endDateController,
                        hintText: 'No date',
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                  color: ColorName.dividerColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RealInnovButton(
                      width: 80,
                      isDisabled: true,
                      text: 'Cancel',
                      onPressed: () => context.pop(),
                    ),
                    16.kwidthBox,
                    RealInnovButton(
                      width: 80,
                      text: 'Save',
                      onPressed: () => context.pop(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 12)
              ],
            )
          ],
        ));
  }
}
