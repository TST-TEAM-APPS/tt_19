import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_19/components/custom_button.dart';
import 'package:tt_19/components/custom_calendar.dart';
import 'package:tt_19/components/custom_text_field.dart';
import 'package:tt_19/core/app_fonts.dart';
import 'package:tt_19/core/colors.dart';
import 'package:tt_19/features/home/goals/model/goals_model.dart';
import 'package:tt_19/features/home/goals/view_model/goal_view_model.dart';

class GoalAddingScreen extends StatefulWidget {
  final GoalViewModel model;
  const GoalAddingScreen({super.key, required this.model});

  @override
  State<GoalAddingScreen> createState() => _GoalAddingScreenState();
}

class _GoalAddingScreenState extends State<GoalAddingScreen> {
  String? name;
  DateTime selectedDate = DateTime.now();
  int? amount;
  int selectedColor = 0xff65BE00;
  String selectedIcon = 'assets/icons/cat.png';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AppBar(),
              const SizedBox(
                height: 20,
              ),
              _AddingForm(
                selectedDate: selectedDate,
                onChangeName: (value) {
                  name = value;
                  setState(() {});
                },
                onChangeDate: (value) {
                  selectedDate = value;
                  setState(() {});
                },
                onChangeAmount: (value) {
                  amount = int.tryParse(value);

                  setState(() {});
                },
                selectedColor: selectedColor,
                onChangeColor: (value) {
                  selectedColor = value;
                  setState(() {});
                },
                selectedIcon: selectedIcon,
                onchangeIcon: (value) {
                  selectedIcon = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Save',
                isValid:
                    name != null && name != '' && amount != null && amount != 0,
                onTap: () {
                  if (name != null && amount != null && amount != null) {
                    widget.model.onGoalAdd(
                      GoalModel(
                        name: name!,
                        goalAmount: amount!,
                        savingModel: [],
                        endingDate: selectedDate,
                        color: selectedColor,
                        imagePath: selectedIcon,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    return null;
                  }
                },
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppColors.primary,
                titleStyle: AppFonts.bodyLarge.copyWith(
                  color: AppColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          highlightColor: AppColors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: AppColors.white,
          ),
        ),
        Text(
          'Add goal',
          style: AppFonts.displayMedium.copyWith(color: AppColors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(
          height: 24,
          width: 24,
        )
      ],
    );
  }
}

class _AddingForm extends StatefulWidget {
  final Function onChangeDate;
  final DateTime selectedDate;
  final Function onChangeName;
  final Function onChangeAmount;
  final int selectedColor;
  final Function onChangeColor;
  final String selectedIcon;
  final Function onchangeIcon;

  const _AddingForm({
    required this.onChangeDate,
    required this.selectedDate,
    required this.onChangeName,
    required this.onChangeAmount,
    required this.selectedColor,
    required this.onChangeColor,
    required this.selectedIcon,
    required this.onchangeIcon,
  });

  @override
  State<_AddingForm> createState() => _AddingFormState();
}

class _AddingFormState extends State<_AddingForm> {
  void _showDatePickeSheet(BuildContext context, Function onChange) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.background,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomCalendar(
                value: [
                  widget.selectedDate,
                ],
                onChangeDate: (value) {
                  onChange(value);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  final List<int> _colors = [
    0xff65BE00,
    0xff0F8DFC,
    0xffFC760F,
    0xff0F52FC,
    0xffF40FFC,
    0xffE29C84
  ];

  int? selectedColor;

  final List<String> _icons = [
    'assets/icons/cat.png',
    'assets/icons/flight.png',
    'assets/icons/book.png',
    'assets/icons/coin.png',
    'assets/icons/joystick.png',
    'assets/icons/lightbulb.png',
    'assets/icons/crown.png',
    'assets/icons/home.png',
    'assets/icons/heart.png',
    'assets/icons/star.png',
  ];

  String? selectedIcon;

  @override
  void initState() {
    selectedColor = widget.selectedColor;
    selectedIcon = widget.selectedIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Goal name*',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: CustomTextField(
              onChange: (value) {
                widget.onChangeName(value);
              },
              hintText: 'First car',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'amount of goal*',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: CustomTextField(
              onChange: (value) {
                widget.onChangeAmount(value);
              },
              keyboardType: TextInputType.number,
              hintText: '\$0',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 163,
            child: _DateTimePicker(
              title: 'Date of ending',
              dateTime: DateFormat('dd.MM.yyyy').format(widget.selectedDate),
              imagePath: 'assets/icons/calendar.png',
              onTap: () {
                _showDatePickeSheet(context, (DateTime value) {
                  widget.onChangeDate(value);
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Choose color',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _colors.map((color) {
                final isSelected = color == selectedColor;
                return GestureDetector(
                  onTap: () {
                    selectedColor = color;
                    print(selectedColor);
                    widget.onChangeColor(selectedColor);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Color(color), width: 3)
                          : Border.all(color: AppColors.secondary, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(color),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            'Choose icon',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final isSelected = _icons[index] == selectedIcon;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIcon = _icons[index];
                      widget.onchangeIcon(selectedIcon);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? Colors.white.withOpacity(0.3)
                          : Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          _icons[index],
                          fit: BoxFit.contain,
                        )),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  final String title;
  final String imagePath;
  final String dateTime;
  final Function onTap;
  const _DateTimePicker({
    required this.title,
    required this.imagePath,
    required this.dateTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.bodyLarge.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              onTap();
            },
            highlightColor: Colors.white.withOpacity(0.5),
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateTime,
                    style: AppFonts.bodyLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Image.asset(
                    imagePath,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
