import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_19/components/custom_calendar.dart';
import 'package:tt_19/core/app_fonts.dart';
import 'package:tt_19/core/colors.dart';

class CurrentDateWIdget extends StatefulWidget {
  final Function onChangeDate;
  final List<DateTime> value;
  const CurrentDateWIdget(
      {super.key, required this.onChangeDate, required this.value});

  @override
  State<CurrentDateWIdget> createState() => _CurrentDateWIdgetState();
}

class _CurrentDateWIdgetState extends State<CurrentDateWIdget> {
  void _showBottomSheet(BuildContext context, Function? onChange) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icons/back.png',
                        width: 34,
                        height: 34,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: AppColors.white,
                        )),
                    child: CustomCalendar(
                      value: widget.value,
                      onChangeDate: (DateTime value) async {
                        await widget.onChangeDate(value);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd EEEE MMMM').format(widget.value[0]);

    return GestureDetector(
      onTap: () {
        _showBottomSheet(context, widget.onChangeDate);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  formattedDate.split(' ').first,
                  style: AppFonts.displayLarge
                      .copyWith(color: AppColors.onBackground),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${formattedDate.split(' ')[1]},\n ${formattedDate.split(' ').last}',
                  style: AppFonts.bodyMedium
                      .copyWith(color: AppColors.onBackground),
                ),
              ],
            ),
            Image.asset(
              'assets/icons/calendar.png',
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
