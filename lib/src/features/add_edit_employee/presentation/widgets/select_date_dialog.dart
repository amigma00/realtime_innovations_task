import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/src/components/real_innov_button.dart';
import 'package:realtime_innovations_task/src/constants/app_colors.dart';
import 'package:realtime_innovations_task/src/constants/app_images.dart';
import 'package:realtime_innovations_task/src/core/extension/padding_extension.dart';
import 'package:realtime_innovations_task/src/core/extension/sizebox_extension.dart';
import 'package:realtime_innovations_task/src/features/add_edit_employee/presentation/helper/select_date_dialog_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateDialog extends StatefulWidget {
  final bool isStartDate;
  const SelectDateDialog({super.key, required this.isStartDate});

  @override
  State<SelectDateDialog> createState() => _SelectDateDialogState();
}

class _SelectDateDialogState extends State<SelectDateDialog> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();

  bool isToday = false;
  bool isNextMonday = false;
  bool isNextTuesday = false;
  bool isNextWeek = false;
  bool isNoDate = false;

  @override
  Widget build(BuildContext context) {
    isToday = isSameDay(selectedDay, DateTime.now());
    isNextMonday =
        isSameDay(selectedDay, SelectDateDialogHelper.getNextMonday());
    isNextTuesday =
        isSameDay(selectedDay, SelectDateDialogHelper.getNextTuesday());
    isNextWeek =
        isSameDay(selectedDay, SelectDateDialogHelper.getDateAfterOneWeek());

    isNoDate = selectedDay == null;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.kheightBox,
          widget.isStartDate ? startDateOptions() : endDateTimeOptions(),
          mainCalendar(context),
          30.kheightBox,
          dateDialogFooter(context)
        ],
      ),
    );
  }

  Widget startDateOptions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RealInnovButton(
                isDisabled: !isToday,
                text: 'Today',
                onPressed: () {
                  setState(() {
                    selectedDay = DateTime.now();
                    focusedDay = DateTime.now();
                  });
                },
              ),
            ),
            16.kwidthBox,
            Expanded(
              child: RealInnovButton(
                isDisabled: !isNextMonday,
                text: 'Next Monday',
                onPressed: () {
                  setState(() {
                    selectedDay = SelectDateDialogHelper.getNextMonday();
                    focusedDay = SelectDateDialogHelper.getNextMonday();
                  });
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        16.kheightBox,
        Row(
          children: [
            Expanded(
              child: RealInnovButton(
                isDisabled: !isNextTuesday,
                text: 'Next Tuesday',
                onPressed: () {
                  setState(() {
                    selectedDay = SelectDateDialogHelper.getNextTuesday();
                    focusedDay = SelectDateDialogHelper.getNextTuesday();
                  });
                },
              ),
            ),
            16.kwidthBox,
            Expanded(
              child: RealInnovButton(
                isDisabled: !isNextWeek,
                text: 'After 1 week',
                onPressed: () {
                  setState(() {
                    selectedDay = SelectDateDialogHelper.getDateAfterOneWeek();
                    focusedDay = SelectDateDialogHelper.getDateAfterOneWeek();
                  });
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget endDateTimeOptions() {
    return Row(
      children: [
        Expanded(
          child: RealInnovButton(
            isDisabled: !isNoDate,
            text: 'No date',
            onPressed: () {
              setState(() {
                selectedDay = null;
                focusedDay = DateTime.now();
              });
            },
          ),
        ),
        16.kwidthBox,
        Expanded(
          child: RealInnovButton(
            isDisabled: !isToday,
            text: 'Today',
            onPressed: () {
              setState(() {
                selectedDay = DateTime.now();
                focusedDay = DateTime.now();
              });
            },
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget mainCalendar(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = focusedDay;
        });
      },
      onHeaderTapped: (focusedDay) async => await showDatePicker(
        context: context,
        firstDate: DateTime.utc(2010, 10, 16),
        lastDate: DateTime.utc(2030, 3, 14),
        initialDatePickerMode: DatePickerMode.year,
      ).then(
        (value) {
          if (value != null) {
            setState(() {
              this.focusedDay = value;
              selectedDay = value;
            });
          }
        },
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        selectedDecoration: BoxDecoration(
          color: ColorName.primary,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: ColorName.primary),
        todayDecoration: !widget.isStartDate
            ? BoxDecoration(
                shape: BoxShape.circle,
              )
            : BoxDecoration(
                border: Border.all(color: ColorName.primary),
                shape: BoxShape.circle,
              ),
        weekendTextStyle: TextStyle(),
      ),
      headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          headerPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 24),
          headerMargin: EdgeInsets.symmetric(horizontal: 8),
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          leftChevronPadding: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero,
          leftChevronIcon: SvgPicture.asset(AppImages.arrowDropDownLeft),
          rightChevronIcon: SvgPicture.asset(AppImages.arrowDropDownRight)),
    );
  }

  Widget dateDialogFooter(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 2,
          thickness: 2,
          color: ColorName.dividerColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              AppImages.calendar,
            ),
            12.kwidthBox,
            Text(SelectDateDialogHelper.getFormattedDate(selectedDay)),
            const Spacer(),
            RealInnovButton(
              width: 80.w,
              isDisabled: true,
              text: 'Cancel',
              onPressed: () => context.pop(),
            ),
            16.kwidthBox,
            RealInnovButton(
              width: 80.w,
              text: 'Save',
              onPressed: () => context.pop(selectedDay),
            ),
          ],
        ).paddingAll(16),
      ],
    );
  }
}
