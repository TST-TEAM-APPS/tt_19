import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';

class CustomCalendar extends StatefulWidget {
  final List<DateTime?> value;
  final Function onChangeDate;
  const CustomCalendar(
      {super.key, required this.value, required this.onChangeDate});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final config = CalendarDatePicker2Config(
    selectedDayHighlightColor: AppColors.primary,
    disableMonthPicker: true,
    disableModePicker: true,
    lastMonthIcon: const Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
    ),
    nextMonthIcon: const Icon(
      Icons.arrow_forward_ios,
      color: Colors.white,
    ),
    weekdayLabels: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
    weekdayLabelTextStyle: AppFonts.bodyMedium.copyWith(color: AppColors.white),
    firstDayOfWeek: 1,
    controlsHeight: 50,
    dayMaxWidth: 25,
    controlsTextStyle: AppFonts.bodySmall.copyWith(color: AppColors.white),
    dayTextStyle: AppFonts.bodyMedium.copyWith(color: AppColors.white),
    disabledDayTextStyle: const TextStyle(
      color: Colors.white,
    ),
    centerAlignModePicker: true,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondary,
      ),
      height: 218,
      child: CalendarDatePicker2(
        config: config,
        value: widget.value,
        onValueChanged: (dates) {
          widget.onChangeDate(dates[0]);
        },
      ),
    );
  }
}
