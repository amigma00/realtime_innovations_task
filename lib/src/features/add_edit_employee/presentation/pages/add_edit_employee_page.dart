import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/src/components/real_innov_button.dart';
import 'package:realtime_innovations_task/src/components/real_innov_text_field.dart';
import 'package:realtime_innovations_task/src/constants/app_colors.dart';
import 'package:realtime_innovations_task/src/constants/app_images.dart';
import 'package:realtime_innovations_task/src/core/di/service_locator.dart';

import 'package:realtime_innovations_task/src/core/extension/padding_extension.dart';
import 'package:realtime_innovations_task/src/core/extension/sizebox_extension.dart';
import 'package:realtime_innovations_task/src/core/util/dialog_helper.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';
import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/cubit/home_cubit.dart';

class AddEditEmployeePage extends StatelessWidget {
  final Employees? employee;
  const AddEditEmployeePage({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddEditEmployeeCubit>()..init(employee),
      child: AddEditEmployeeView(
        employee: employee,
      ),
    );
  }
}

class AddEditEmployeeView extends StatelessWidget {
  final Employees? employee;

  const AddEditEmployeeView({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditEmployeeCubit>();

    return BlocListener<AddEditEmployeeCubit, AddEditEmployeeState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is AddEditEmployeeAdded) {
          // hideDialog(context);
          context.pop(true);
          const snackBar = SnackBar(
            content: Text('Employee added successfully!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is AddEditEmployeeEditted) {
          // hideDialog(context);
          sl<HomeCubit>().getEmployees();
          Navigator.of(context).pop('yes');

          const snackBar = SnackBar(
            content: Text('Employee editted successfully!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is AddEditEmployeeFailed) {
          // hideDialog(context);
          const snackBar = SnackBar(
            content: Text('Something went wrong!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(employee == null
                ? 'Add Employee Details'
                : 'Edit Employee Details'),
          ),
          body: Column(
            children: [
              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    24.kheightBox,
                    RealInnovTexTField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter employee name';
                        } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Enter a proper name';
                        }
                        return null;
                      },
                      prefixIcon: SvgPicture.asset(
                        AppImages.employeeIcon,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                      controller: cubit.empNameController,
                      hintText: 'Employee name',
                    ),
                    24.kheightBox,
                    RealInnovTexTField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter employee role';
                        }
                        return null;
                      },
                      onTap: () => cubit.onRoleSelected(context),
                      readOnly: true,
                      prefixIcon: SvgPicture.asset(
                        AppImages.jobRole,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                      suffixIcon: SvgPicture.asset(
                        AppImages.arrowDropDown,
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
                            onTap: () => cubit.onDateWidgetTapped(context,
                                isStartDate: true),
                            readOnly: true,
                            prefixIcon: SvgPicture.asset(
                              AppImages.calendar,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                            controller: cubit.startDateController,
                            hintText: 'No date',
                          ),
                        ),
                        SvgPicture.asset(
                          AppImages.arrowRight,
                        ).paddingSymmetric(horizontal: 16),
                        Expanded(
                          child: RealInnovTexTField(
                            onTap: () => cubit.onDateWidgetTapped(context,
                                isStartDate: false),
                            readOnly: true,
                            prefixIcon: SvgPicture.asset(
                              AppImages.calendar,
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
              ),
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
                        onPressed: () => cubit.onSaveTapped(),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 12)
                ],
              )
            ],
          )),
    );
  }
}
