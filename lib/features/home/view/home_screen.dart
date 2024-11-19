import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tt_25/components/custom_button.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/model/weekly_transactions_model.dart';
import 'package:tt_25/features/home/logic/view_model/home_screen_view_model.dart';
import 'package:tt_25/features/home/view/transactions_add.dart';

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
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
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
              _RecentTransactions(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _RecentTransactions extends StatelessWidget {
  const _RecentTransactions();
  String formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today ${DateFormat('HH:mm').format(date)}";
    } else if (difference == 1) {
      return "Yesterday ${DateFormat('HH:mm').format(date)}";
    } else {
      return "$difference days ago ${DateFormat('HH:mm').format(date)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final weeklyTransactionListModel =
        context.select<HomeScreenViewModel, WeeklyTransactionsModel>(
            (provider) => provider.homeScreenState.weeklyTransactions);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent transactions',
              style: AppFonts.bodyLarge.copyWith(
                color: AppColors.white,
              ),
            ),
            CustomButton.alert(
              title: 'See all',
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              titleStyle: AppFonts.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset(
                            weeklyTransactionListModel
                                .transactionModelList[index].category.imagePath,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${weeklyTransactionListModel.transactionModelList[index].transactionsType.toString().split('.').last}: ${weeklyTransactionListModel.transactionModelList[index].name}',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.green,
                                ),
                              ),
                              Text(
                                formatTransactionDate(weeklyTransactionListModel
                                    .transactionModelList[index].date),
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      '${weeklyTransactionListModel.transactionModelList[index].transactionsType == TransactionType.income ? '+\$' : '-\$'}${weeklyTransactionListModel.transactionModelList[index].amount}',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount:
                weeklyTransactionListModel.transactionModelList.length > 5
                    ? 5
                    : weeklyTransactionListModel.transactionModelList.length),
        if (weeklyTransactionListModel.transactionModelList.isEmpty)
          Text(
            'No transactions yet',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.white,
            ),
          )
      ],
    );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TransactionsAdd(
                              model: model,
                              transactionType: TransactionType.income,
                            )));
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
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TransactionsAdd(
                              model: model,
                              transactionType: TransactionType.expense,
                            )));
              },
              borderRadius: BorderRadius.circular(10),
              highlightColor: AppColors.white.withOpacity(0.5),
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
  List<BarChartGroupData> showingEmptyBarGroups = [];

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

  void showingEmptyBarGroupsData() {
    final barGroup1 = makeEmptyGroupData(0, 2, 3);
    final barGroup2 = makeEmptyGroupData(1, 4, 5);
    final barGroup3 = makeEmptyGroupData(2, 6, 7);
    final barGroup4 = makeEmptyGroupData(3, 8, 9);
    final barGroup5 = makeEmptyGroupData(4, 10, 11);
    final barGroup6 = makeEmptyGroupData(5, 12, 13);
    final barGroup7 = makeEmptyGroupData(6, 14, 15);
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
    showingEmptyBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    final weeklyTransactionListModel =
        context.select<HomeScreenViewModel, WeeklyTransactionsModel>(
            (provider) => provider.homeScreenState.weeklyTransactions);
    showingBarGroupsData(weeklyTransactionListModel);
    showingEmptyBarGroupsData();
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
            height: 40,
          ),
          if (weeklyTransactionListModel.transactionModelList.isEmpty)
            Column(
              children: [
                Text(
                  'Your history will be displayed here',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: BarChart(
                    BarChartData(
                      maxY: 36,
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
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
                      barGroups: showingEmptyBarGroups,
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          if (weeklyTransactionListModel.transactionModelList.isNotEmpty)
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: weeklyTransactionListModel.getMaxAmount(),
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
                              ? '\$${(weeklyTransactionListModel.getIncome(groupIndex + 1) - weeklyTransactionListModel.getExpense(groupIndex + 1)).round()}'
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
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: Colors.white);
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

  BarChartGroupData makeEmptyGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 0,
      x: x,
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
