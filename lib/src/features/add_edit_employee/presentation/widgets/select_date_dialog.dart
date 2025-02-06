import 'package:flutter/material.dart';
import 'package:realtime_innovations_task/gen/assets.gen.dart';
import 'package:realtime_innovations_task/gen/colors.gen.dart';
import 'package:realtime_innovations_task/src/components/real_innov_button.dart';
import 'package:realtime_innovations_task/src/core/extension/padding_extension.dart';
import 'package:realtime_innovations_task/src/core/extension/sizebox_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateDialog extends StatefulWidget {
  const SelectDateDialog({super.key});

  @override
  State<SelectDateDialog> createState() => _SelectDateDialogState();
}

class _SelectDateDialogState extends State<SelectDateDialog> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  bool isToday = false;
  bool nextMonday = false;
  bool nextTuesday = false;
  bool nextWeek = false;

  @override
  Widget build(BuildContext context) {
    isToday = isSameDay(selectedDay, DateTime.now());
    nextMonday = isSameDay(selectedDay, getNextMonday());
    nextTuesday = isSameDay(selectedDay, getNextTuesday());
    nextWeek = isSameDay(selectedDay, getDateAfterOneWeek());
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          24.kheightBox,
          Row(
            children: [
              Expanded(
                child: RealInnovButton(
                  width: 80,
                  isDisabled: !isToday,
                  text: 'Today',
                  onPressed: () {},
                ),
              ),
              16.kwidthBox,
              Expanded(
                child: RealInnovButton(
                  isDisabled: !nextMonday,
                  width: 80,
                  text: 'Next Monday',
                  onPressed: () {
                    setState(() {
                      selectedDay = getNextMonday();
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
                  width: 80,
                  isDisabled: !nextTuesday,
                  text: 'Next Tuesday',
                  onPressed: () {
                    setState(() {
                      selectedDay = getNextTuesday();
                    });
                  },
                ),
              ),
              16.kwidthBox,
              Expanded(
                child: RealInnovButton(
                  isDisabled: !nextWeek,
                  width: 80,
                  text: 'After 1 week',
                  onPressed: () {
                    setState(() {
                      selectedDay = getDateAfterOneWeek();
                    });
                  },
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          TableCalendar(
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
              todayDecoration: BoxDecoration(
                // color: Colors.purple,
                border: Border.all(color: ColorName.primary),
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(),
              // defaultTextStyle: TextStyle(color: Colors.white),
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
              leftChevronIcon: Assets.svgs.arrowDropDownLeft.svg(),
              rightChevronIcon: Assets.svgs.arrowDropDownRight.svg(),
            ),
          )
        ],
      ),
    );
  }

  DateTime getNextMonday() {
    DateTime today = DateTime.now();
    int daysUntilMonday = (DateTime.monday - today.weekday + 7) % 7;
    daysUntilMonday = daysUntilMonday == 0
        ? 7
        : daysUntilMonday; // If today is Monday, get next Monday
    return today.add(Duration(days: daysUntilMonday));
  }

  DateTime getNextTuesday() {
    DateTime today = DateTime.now();
    int daysUntilTuesday = (DateTime.tuesday - today.weekday + 7) % 7;
    daysUntilTuesday = daysUntilTuesday == 0
        ? 7
        : daysUntilTuesday; // If today is Monday, get next Monday
    return today.add(Duration(days: daysUntilTuesday));
  }

  DateTime getDateAfterOneWeek() {
    DateTime today = DateTime.now();
    return today.add(Duration(days: 7));
  }
}
