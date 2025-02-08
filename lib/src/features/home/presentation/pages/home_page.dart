import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:realtime_innovations_task/src/constants/app_colors.dart';
import 'package:realtime_innovations_task/src/constants/app_images.dart';
import 'package:realtime_innovations_task/src/core/extension/sizebox_extension.dart';

import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/cubit/add_edit_employee_cubit.dart';

import 'package:realtime_innovations_task/src/features/home/data/models/employee_model.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/helper/home_page_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = GetIt.I<HomeCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.init();
  }

  List<Employees> employees = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          // hideDialog(context);
          employees = state.employees;
        }
        if (state is HomeFailed) {
          // hideDialog(context);
          const snackBar = SnackBar(
            content: Text('Something went wrong!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is HomeDeleted) {
          // hideDialog(context);
          setState(() {});
          const snackBar = SnackBar(
            content: Text('Employee deleted!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: ColorName.dividerColor,
            appBar: AppBar(
              centerTitle: false,
              title: Text('Home Page'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<HomeCubit>().onFabPressed(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: ColorName.primary,
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
            body: employees.isEmpty ? noEmployess() : listEmployees(employees));
      },
    );
  }

  Widget noEmployess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AppImages.noEmployee, height: 240, width: 260),
        100.kheightBox
      ],
    );
  }

  Widget listEmployees(List<Employees> employees) {
    Map<String, List<Employees>> employeeMap = {
      'Current Employees': employees
          .where((emp) =>
              emp.endDate == null ||
              (emp.endDate?.isAfter(DateTime.now()) ?? false))
          .toList(),
      'Previous Employees': employees
          .where((emp) =>
              emp.endDate != null &&
              (emp.endDate?.isBefore(DateTime.now()) ?? false))
          .toList(),
    };
    print(employeeMap);
    List<String> sectionTitles = employeeMap.keys.toList();
    return CustomScrollView(slivers: [
      for (var sectionTitle in sectionTitles)
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Visibility(
              visible: employeeMap[sectionTitle]?.isNotEmpty ?? false,
              child: ListTile(
                tileColor: ColorName.border,
                title: Text(
                  sectionTitle,
                  style: TextStyle(
                    color: ColorName.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ...employeeMap[sectionTitle]!.map(
              (emp) => Column(
                children: [
                  Dismissible(
                    onDismissed: (direction) async {
                      final item = emp;
                      await cubit.deleteEmployee(emp.dbId ?? 0).then((value) {
                        if (!value && mounted) {
                          context
                              .read<AddEditEmployeeCubit>()
                              .getUsecase
                              .addEmployee(item);
                        }
                      });
                      setState(() {
                        employees
                            .removeWhere((element) => element.dbId == emp.dbId);
                      });
                    },
                    direction: DismissDirection.endToStart,
                    background: SizedBox.shrink(),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(AppImages.delete),
                    ),
                    // key: Key(employees[index].dbId.toString()),
                    key: UniqueKey(),

                    child: ListTile(
                      dense: true,
                      minVerticalPadding: 0,
                      onTap: () => cubit.onEmployeeTap(context, emp),
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        emp.name ?? '',
                        style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      subtitle: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${emp.role}\n',
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: ColorName.subTitle),
                            ),
                            TextSpan(
                              text: getFromToDate(emp.startDate, emp.endDate),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: ColorName.subTitle),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: ColorName.border,
                  ),
                ],
              ),
            ),
          ],
        ))
    ]);
  }
}

String getFromToDate(DateTime? startDate, DateTime? endDate) {
  if (startDate != null) {
    var x = HomePageHelper.getFormattedDate(startDate);
    if (endDate == null) {
      return 'From $x';
    } else {
      var y = HomePageHelper.getFormattedDate(endDate);
      return '$x - $y';
    }
  } else {
    return '';
  }
}
