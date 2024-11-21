import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tt_25/components/custom_button.dart';
import 'package:tt_25/components/custom_text_field.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/goals/model/goals_model.dart';
import 'package:tt_25/features/home/goals/view/goal_savings_list_screen.dart';
import 'package:tt_25/features/home/goals/view_model/goal_view_model.dart';

class GoalDetailsScreen extends StatefulWidget {
  final GoalModel model;
  final GoalViewModel viewModel;
  const GoalDetailsScreen(
      {super.key, required this.model, required this.viewModel});

  @override
  State<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends State<GoalDetailsScreen> {
  String daysLeft(DateTime targetDate) {
    final currentDate = DateTime.now();
    final difference = targetDate.difference(currentDate).inDays;

    if (difference > 0) {
      return '$difference days left';
    } else {
      return 'The date has passed';
    }
  }

  late final GoalModel currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.viewModel.goalState.goalist.firstWhere(
      (e) => e.id == widget.model.id,
      orElse: () {
        throw Exception("GoalModel with ID ${widget.model.id} not found.");
      },
    );
  }

  String formatTransactionDateWithoutTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      return DateFormat('MMM. d').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AppBar(widget.model, widget.viewModel),
                  const SizedBox(
                    height: 20,
                  ),
                  _NumberWidget(widget: widget),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Savings',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        daysLeft(widget.model.endingDate),
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: BarChartSample1(
                      viewModel: widget.viewModel,
                      goalModel: widget.model,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Added savings',
                        style: AppFonts.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      CustomButton.alert(
                        title: 'See all',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GoalSavingsListScreen(
                                currentModel: widget.model,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        titleStyle: AppFonts.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (currentModel.savingModel.isEmpty)
                    Text(
                      'No savings yet',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.green,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.white.withOpacity(0.5),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentModel.name,
                                      style: AppFonts.bodyMedium.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$${currentModel.savingModel[index].savingAmount}',
                                      style: AppFonts.bodyMedium.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatTransactionDateWithoutTime(
                                          currentModel
                                              .savingModel[index].createdDate),
                                      style: AppFonts.bodyMedium.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: currentModel.savingModel.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              title: 'Add money',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => _CustomModal(
                    model: widget.viewModel,
                    onChange: (value) {
                      final updatedSavingModel = [
                        ...widget.model.savingModel,
                        SavingModel(
                            savingAmount: value!, createdDate: DateTime.now()),
                      ];
                      widget.viewModel.onUpdatedGoal(
                        widget.model.copyWith(savingModel: updatedSavingModel),
                      );
                      setState(() {});
                    },
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              backgroundColor: AppColors.primary,
              titleStyle: AppFonts.bodyLarge.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class _NumberWidget extends StatelessWidget {
  const _NumberWidget({
    required this.widget,
  });

  final GoalDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current savings',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            ),
            Text(
              'Goal amount',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${widget.viewModel.getTotalSavings(widget.model)}',
              style: AppFonts.displayLarge.copyWith(
                color: AppColors.white,
              ),
            ),
            Text(
              '\$${widget.model.goalAmount.toString()}',
              style: AppFonts.displayLarge.copyWith(
                color: AppColors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(this.model, this.viewModel);
  final GoalModel model;
  final GoalViewModel viewModel;
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
          model.name,
          style: AppFonts.displayMedium.copyWith(color: AppColors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        InkWell(
          highlightColor: AppColors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            viewModel.onDeleteGoal(model);
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.delete,
            size: 24,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class _CustomModal extends StatefulWidget {
  final GoalViewModel model;
  final Function onChange;
  const _CustomModal({required this.model, required this.onChange});
  @override
  State<_CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<_CustomModal> {
  int? money;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount of saving',
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.white,
                )),
            const SizedBox(height: 16),
            CustomTextField(
              onChange: (value) {
                money = int.tryParse(value);
                setState(() {});
              },
              hintText: '\$0',
              keyboardType: TextInputType.number,
              textStyle: AppFonts.bodyLarge.copyWith(
                color: AppColors.white,
              ),
              fillColor: AppColors.green,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style:
                          AppFonts.bodyLarge.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: money == null
                        ? null
                        : () {
                            widget.onChange(money);

                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: AppColors.background,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: AppFonts.bodyLarge.copyWith(
                          color: money == null
                              ? AppColors.background
                              : AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartSample1 extends StatefulWidget {
  final GoalViewModel viewModel;
  final GoalModel goalModel;
  const BarChartSample1(
      {super.key, required this.viewModel, required this.goalModel});

  final Color barBackgroundColor = AppColors.background;
  final Color barColor = AppColors.primary;
  final Color touchedBarColor = AppColors.secondary;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  late final GoalModel currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.viewModel.goalState.goalist.firstWhere(
      (e) => e.id == widget.goalModel.id,
      orElse: () {
        throw Exception("GoalModel with ID ${widget.goalModel.id} not found.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        mainBarData(),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    Color? barColor,
    double width = 40,
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  List<BarChartGroupData> showingGroups() {
    final currentDate = DateTime.now();
    final last7Days = List.generate(
      7,
      (index) => currentDate.subtract(Duration(days: index)),
    );

    final dailySums = {
      for (var day in last7Days) DateTime(day.year, day.month, day.day): 0
    };

    for (final saving in currentModel.savingModel) {
      final savingDate = DateTime(
        saving.createdDate.year,
        saving.createdDate.month,
        saving.createdDate.day,
      );

      if (dailySums.containsKey(savingDate)) {
        dailySums[savingDate] =
            ((dailySums[savingDate] ?? 0) + saving.savingAmount).toInt();
      }
    }

    return last7Days.reversed.mapIndexed((index, day) {
      final amount = dailySums[DateTime(day.year, day.month, day.day)] ?? 0;
      return makeGroupData(index, amount.toDouble());
    }).toList();
  }

  Widget getTitlesWidget(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= 7) return const SizedBox.shrink();

    final currentDate = DateTime.now();
    final date = currentDate.subtract(Duration(days: 6 - index));
    final formattedDate = DateFormat('MMM. d').format(date);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        formattedDate,
        style: AppFonts.bodyMedium.copyWith(color: AppColors.white),
      ),
    );
  }

  BarChartData mainBarData() {
    final currentDate = DateTime.now();
    final last7Days = List.generate(
      7,
      (index) => currentDate.subtract(Duration(days: index)),
    );

    final dailySums = {
      for (var day in last7Days) DateTime(day.year, day.month, day.day): 0
    };

    for (final saving in currentModel.savingModel) {
      final savingDate = DateTime(
        saving.createdDate.year,
        saving.createdDate.month,
        saving.createdDate.day,
      );

      if (dailySums.containsKey(savingDate)) {
        dailySums[savingDate] =
            ((dailySums[savingDate] ?? 0) + saving.savingAmount).toInt();
      }
    }

    final maxY = dailySums.values.isNotEmpty
        ? dailySums.values.reduce((a, b) => a > b ? a : b).toDouble()
        : 100;
    return BarChartData(
      maxY: maxY.toDouble(),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipHorizontalOffset: 5,
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final amount = rod.toY.toInt();
            return BarTooltipItem(
              '\$$amount',
              AppFonts.bodySmall.copyWith(color: AppColors.white),
            );
          },
        ),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitlesWidget,
            reservedSize: 32,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }
}
