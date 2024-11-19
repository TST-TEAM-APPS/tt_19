import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/model/weekly_transactions_model.dart';
import 'package:tt_25/features/home/logic/view_model/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BalanceLabel(),
              SizedBox(
                height: 20,
              ),
              _TransactionButtons(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: BarChartSample2(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _TransactionButtons extends StatelessWidget {
  const _TransactionButtons();

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeScreenViewModel>();
    return Row(
      children: [
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary,
            child: InkWell(
              highlightColor: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                model.onTransactionAdd(
                  TransactionModel(
                    name: 'name',
                    amount: 200,
                    comment: 'comment',
                    date: DateTime.now(),
                    transactionsType: TransactionType.income,
                    category:
                        Category(name: 'name', categoryType: CategoryType.main),
                  ),
                );
                model.onTransactionAdd(
                  TransactionModel(
                    name: 'name',
                    amount: 20,
                    comment: 'comment',
                    date: DateTime.now(),
                    transactionsType: TransactionType.expense,
                    category:
                        Category(name: 'name', categoryType: CategoryType.main),
                  ),
                );
              },
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add income',
                        style: AppFonts.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/icons/arrow-iskos.png',
                        width: 14,
                        height: 14,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add expense',
                    style: AppFonts.bodyLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/icons/arrow_iskos_right.png',
                    width: 14,
                    height: 14,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BalanceLabel extends StatelessWidget {
  const _BalanceLabel();

  @override
  Widget build(BuildContext context) {
    final balance = context.select<HomeScreenViewModel, String>(
        (provider) => provider.homeScreenState.balance);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your balance:',
          style: AppFonts.displayLarge.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '\$$balance',
          style: AppFonts.displayLarge.copyWith(
            color: AppColors.white,
          ),
        )
      ],
    );
  }
}

class BarChartSample2 extends StatefulWidget {
  const BarChartSample2({super.key});
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 20;

  late List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  void showingBarGroupsData(WeeklyTransactionsModel weeklyTransationsModel) {
    final barGroup1 = makeGroupData(0, weeklyTransationsModel.getIncome(1),
        weeklyTransationsModel.getExpense(1));
    final barGroup2 = makeGroupData(1, weeklyTransationsModel.getIncome(2),
        weeklyTransationsModel.getExpense(2));
    final barGroup3 = makeGroupData(2, weeklyTransationsModel.getIncome(3),
        weeklyTransationsModel.getExpense(3));
    final barGroup4 = makeGroupData(3, weeklyTransationsModel.getIncome(4),
        weeklyTransationsModel.getExpense(4));
    final barGroup5 = makeGroupData(4, weeklyTransationsModel.getIncome(5),
        weeklyTransationsModel.getExpense(5));
    final barGroup6 = makeGroupData(5, weeklyTransationsModel.getIncome(6),
        weeklyTransationsModel.getExpense(6));
    final barGroup7 = makeGroupData(6, weeklyTransationsModel.getIncome(7),
        weeklyTransationsModel.getExpense(7));

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    final weeklyTransactionListModel =
        context.select<HomeScreenViewModel, WeeklyTransactionsModel>(
            (provider) => provider.homeScreenState.weeklyTransactions);
    showingBarGroupsData(weeklyTransactionListModel);
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'History',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: 3000,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipHorizontalOffset: 5,
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 0,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        weeklyTransactionListModel.getIncome(groupIndex + 1) -
                                    weeklyTransactionListModel
                                        .getExpense(groupIndex + 1) <
                                0
                            ? '-\$${(weeklyTransactionListModel.getIncome(groupIndex + 1) - weeklyTransactionListModel.getExpense(groupIndex + 1)).round()}'
                            : '\$${(weeklyTransactionListModel.getIncome(groupIndex + 1) - weeklyTransactionListModel.getExpense(groupIndex + 1)).round()}',
                        const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  touchCallback: (FlTouchEvent event, response) {
                    if (response == null || response.spot == null) {
                      setState(() {
                        touchedGroupIndex = -1;
                        showingBarGroups = List.of(rawBarGroups);
                      });
                      return;
                    }

                    touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                    setState(() {
                      if (!event.isInterestedForInteractions) {
                        touchedGroupIndex = -1;
                        showingBarGroups = List.of(rawBarGroups);
                        return;
                      }
                      showingBarGroups = List.of(rawBarGroups);
                      if (touchedGroupIndex != -1) {
                        var sum = 0.0;
                        for (final rod
                            in showingBarGroups[touchedGroupIndex].barRods) {
                          sum += rod.toY;
                        }
                        final avg = sum /
                            showingBarGroups[touchedGroupIndex].barRods.length;

                        showingBarGroups[touchedGroupIndex] =
                            showingBarGroups[touchedGroupIndex].copyWith(
                          barRods: showingBarGroups[touchedGroupIndex]
                              .barRods
                              .map((rod) {
                            return rod.copyWith(toY: avg, color: Colors.white);
                          }).toList(),
                        );
                      }
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      interval: 1,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        interval: 1,
                        reservedSize: 35),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: showingBarGroups,
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sut', 'Sun'];

    final Widget text = Text(
      titles[value.toInt()],
      style: AppFonts.bodyMedium.copyWith(
        color: AppColors.white,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 0,
      x: x,
      showingTooltipIndicators: [0],
      barRods: [
        BarChartRodData(
            toY: y1,
            color: AppColors.primary,
            width: width,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        BarChartRodData(
            toY: y2,
            color: AppColors.green,
            width: width,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      ],
    );
  }
}
