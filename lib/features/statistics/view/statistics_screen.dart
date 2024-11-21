import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/statistics/logic/model/date_filter_model.dart';
import 'package:tt_25/features/statistics/logic/view_model/statistic_screen_view_model.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
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

  final List<DateFilterModel> dropDownModelList = [
    DateFilterModel.allTime,
    DateFilterModel.today,
    DateFilterModel.yesterday,
    DateFilterModel.lastWeek,
    DateFilterModel.lastYear
  ];

  DateFilterModel selectedDateFilter = DateFilterModel.allTime;

  final List<CategoryType> dropDonwCategoryTypeModelList = [
    CategoryType.all,
    CategoryType.main,
    CategoryType.secondary,
    CategoryType.thirdly,
  ];

  CategoryType selectedCategoryFilter = CategoryType.all;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticScreenViewModel>();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  'Statistics',
                  style:
                      AppFonts.displayMedium.copyWith(color: AppColors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const _TransactionButtons(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'select',
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      items:
                          List.generate(dropDownModelList.length, (int index) {
                        return DropdownMenuItem(
                            value: dropDownModelList[index].name,
                            child: Text(
                              dropDownModelList[index].name,
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ));
                      }),
                      value: selectedDateFilter.name,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedDateFilter =
                                DateFilterModelExtension.fromString(value);
                            model.updateFilter(
                                selectedDateFilter,
                                selectedCategoryFilter,
                                model.statisticScreenState
                                    .currentTransactionType);
                          }
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 30,
                        padding: const EdgeInsets.only(left: 5, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondary,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: Transform.rotate(
                          angle: 3.14159 / 2,
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                        ),
                        iconSize: 20,
                        iconEnabledColor: AppColors.white,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        offset: const Offset(0, 30),
                        elevation: 0,
                        scrollbarTheme: const ScrollbarThemeData(
                            thumbColor:
                                WidgetStatePropertyAll(AppColors.background)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondary,
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 30,
                        padding: EdgeInsets.only(left: 15, right: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'select',
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      items: List.generate(dropDonwCategoryTypeModelList.length,
                          (int index) {
                        return DropdownMenuItem(
                            value: dropDonwCategoryTypeModelList[index].name,
                            child: Text(
                              dropDonwCategoryTypeModelList[index].name,
                              style: AppFonts.bodyMedium
                                  .copyWith(color: AppColors.white),
                            ));
                      }),
                      value: selectedCategoryFilter.name,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            selectedCategoryFilter =
                                CategoryTypeModelExtension.fromString(value);
                            model.updateFilter(
                              selectedDateFilter,
                              selectedCategoryFilter,
                              model.statisticScreenState.currentTransactionType,
                            );
                          }
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 30,
                        padding: const EdgeInsets.only(left: 5, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondary,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: IconStyleData(
                        icon: Transform.rotate(
                          angle: 3.14159 / 2,
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                        ),
                        iconSize: 20,
                        iconEnabledColor: AppColors.white,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        offset: const Offset(0, 30),
                        elevation: 0,
                        scrollbarTheme: const ScrollbarThemeData(
                            thumbColor:
                                WidgetStatePropertyAll(AppColors.white)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondary,
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 30,
                        padding: EdgeInsets.only(left: 20, right: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (model.statisticScreenState.transactionList.isEmpty)
              Text(
                'No transactions yet',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.statisticScreenState.dateTimeMapHelper
                        .containsValue(index))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          formatTransactionDateWithoutTime(model
                              .statisticScreenState
                              .transactionList[index]
                              .date),
                          style: AppFonts.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: model.statisticScreenState.transactionList[index]
                                    .transactionsType ==
                                TransactionType.income
                            ? AppColors.green
                            : AppColors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  model
                                      .statisticScreenState
                                      .transactionList[index]
                                      .category
                                      .imagePath,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '${model.statisticScreenState.transactionList[index].transactionsType.toString().split('.').last}: ',
                                        style: AppFonts.bodyMedium.copyWith(
                                          color: AppColors.background,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: model.statisticScreenState
                                                .transactionList[index].name,
                                            style: AppFonts.bodyMedium.copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      formatTransactionDate(model
                                          .statisticScreenState
                                          .transactionList[index]
                                          .date),
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
                            '${model.statisticScreenState.transactionList[index].transactionsType == TransactionType.income ? '+\$' : '-\$'}${model.statisticScreenState.transactionList[index].amount}',
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              itemCount: model.statisticScreenState.transactionList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          ],
        ),
      )),
    ));
  }
}

class _TransactionButtons extends StatelessWidget {
  const _TransactionButtons();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<StatisticScreenViewModel>();

    return Row(
      children: [
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: model.statisticScreenState.currentTransactionType ==
                    TransactionType.income
                ? AppColors.primary
                : AppColors.secondary,
            child: InkWell(
              highlightColor: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                model.updateFilter(
                    model.statisticScreenState.currentDateFilter,
                    model.statisticScreenState.currentCategoryType,
                    TransactionType.income);
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
                        'Income',
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
            color: model.statisticScreenState.currentTransactionType ==
                    TransactionType.expense
                ? AppColors.primary
                : AppColors.secondary,
            child: InkWell(
              onTap: () {
                model.updateFilter(
                    model.statisticScreenState.currentDateFilter,
                    model.statisticScreenState.currentCategoryType,
                    TransactionType.expense);
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
                        'Expense',
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
