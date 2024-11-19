import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_25/components/custom_app_bar.dart';
import 'package:tt_25/components/custom_button.dart';
import 'package:tt_25/components/custom_calendar.dart';
import 'package:tt_25/components/custom_text_field.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/view_model/home_screen_view_model.dart';

class TransactionsAdd extends StatefulWidget {
  final TransactionType transactionType;
  final HomeScreenViewModel model;
  const TransactionsAdd(
      {super.key, required this.transactionType, required this.model});

  @override
  State<TransactionsAdd> createState() => _TransactionsAddState();
}

class _TransactionsAddState extends State<TransactionsAdd> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();
  String? name;
  double? amount;
  String? comment;
  Category? category;

  DateTime combineDateAndTime(DateTime date, DateTime time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title:
                      'Add ${widget.transactionType.toString().split('.').last}',
                ),
                const SizedBox(
                  height: 20,
                ),
                _AddingForm(
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  transactionType: widget.transactionType,
                  onChangeDate: (value) {
                    selectedDate = value;
                    setState(() {});
                  },
                  onChangeCategory: (value) {
                    category = value;
                    setState(() {});
                  },
                  onChangeTime: (value) {
                    selectedTime = value;
                    setState(() {});
                  },
                  onChangeName: (value) {
                    name = value;
                    setState(() {});
                  },
                  onChangeAmount: (value) {
                    amount = double.tryParse(value);
                    setState(() {});
                  },
                  onChangeComment: (value) {
                    comment = value;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 42,
                ),
                CustomButton(
                  title: 'Save',
                  isValid: name != null &&
                      name != '' &&
                      amount != null &&
                      comment != null &&
                      comment != '' &&
                      category != null,
                  onTap: () {
                    if (name != null &&
                        amount != null &&
                        comment != null &&
                        category != null) {
                      widget.model.onTransactionAdd(TransactionModel(
                          name: name!,
                          amount: amount!.round(),
                          comment: comment!,
                          date: combineDateAndTime(selectedDate, selectedTime),
                          transactionsType: widget.transactionType,
                          category: category!));
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
      ),
    );
  }
}

class _AddingForm extends StatefulWidget {
  final TransactionType transactionType;
  final Function onChangeTime;
  final Function onChangeDate;
  final DateTime selectedDate;
  final DateTime selectedTime;
  final Function onChangeName;
  final Function onChangeComment;
  final Function onChangeAmount;
  final Function onChangeCategory;

  const _AddingForm({
    required this.transactionType,
    required this.onChangeTime,
    required this.onChangeDate,
    required this.selectedDate,
    required this.selectedTime,
    required this.onChangeName,
    required this.onChangeComment,
    required this.onChangeAmount,
    required this.onChangeCategory,
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
                value: [widget.selectedTime],
                onChangeDate: (value) {
                  onChange(value);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  void _showTimePicker(BuildContext context, Function onChange) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          color: AppColors.background,
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: AppFonts.bodyLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (newTime) {
                  onChange(newTime);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.transactionType.toString().split('.').last} name*',
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
              hintText: widget.transactionType == TransactionType.income
                  ? 'My jod'
                  : 'Shopping',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'amount of ${widget.transactionType.toString().split('.').last}*',
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
              hintText: widget.transactionType == TransactionType.income
                  ? '\$0'
                  : '-\$0',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _DateTimePicker(
                title: 'Date *',
                dateTime: DateFormat('dd.MM.yyyy').format(widget.selectedDate),
                imagePath: 'assets/icons/calendar.png',
                onTap: () {
                  _showDatePickeSheet(context, (DateTime value) {
                    widget.onChangeDate(value);
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              _DateTimePicker(
                title: 'Time *',
                dateTime: DateFormat('HH:mm').format(widget.selectedTime),
                imagePath: 'assets/icons/clock.png',
                onTap: () {
                  _showTimePicker(context, (DateTime value) {
                    widget.onChangeTime(value);
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Comment*',
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
                widget.onChangeComment(value);
              },
              hintText: widget.transactionType == TransactionType.income
                  ? 'Today I did more than yesterday'
                  : 'I bought a new jacket',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Choose category *',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CategorySelectionScreen(
            onChange: (value) {
              widget.onChangeCategory(value);
            },
          )
        ],
      ),
    );
  }
}

class CategorySelectionScreen extends StatefulWidget {
  final Function onChange;
  const CategorySelectionScreen({super.key, required this.onChange});

  @override
  CategorySelectionScreenState createState() => CategorySelectionScreenState();
}

class CategorySelectionScreenState extends State<CategorySelectionScreen> {
  Category? _selectedCategory;

  final List<Category> _categories = [
    Category(
        categoryType: CategoryType.main, imagePath: 'assets/icons/coin.png'),
    Category(
        categoryType: CategoryType.secondary,
        imagePath: 'assets/icons/crown.png'),
    Category(
        categoryType: CategoryType.thirdly, imagePath: 'assets/icons/star.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: _categories.map((category) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                  widget.onChange(_selectedCategory);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                    color: _selectedCategory == category
                        ? AppColors.secondary
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        category.imagePath,
                        color: Colors.white,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        category.categoryType.toString().split('.').last,
                        style: AppFonts.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
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
    return Expanded(
      child: Column(
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
      ),
    );
  }
}
