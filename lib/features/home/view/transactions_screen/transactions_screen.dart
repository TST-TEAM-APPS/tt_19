import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tt_19/components/custom_calendar.dart';
import 'package:tt_19/core/app_fonts.dart';
import 'package:tt_19/core/colors.dart';
import 'package:tt_19/features/home/logic/model/transactions_model.dart';
import 'package:tt_19/features/home/logic/view_model/home_screen_view_model.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
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

  DateTime dateTime = DateTime.now();

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
                value: [dateTime],
                onChangeDate: (value) {
                  onChange(value);
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeScreenViewModel>();
    model.sortDate();

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
                  'Transactions',
                  style:
                      AppFonts.displayMedium.copyWith(color: AppColors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                InkWell(
                  highlightColor: AppColors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    _showDatePickeSheet(context, (value) {
                      dateTime = value;
                      model.updateDate(dateTime);
                    });
                  },
                  child: Image.asset(
                    'assets/icons/calendar.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.homeScreenState.dateTimeMapHelper
                        .containsValue(index))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          formatTransactionDateWithoutTime(model
                              .homeScreenState.transactionList[index].date),
                          style: AppFonts.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: model.homeScreenState.transactionList[index]
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
                                  model.homeScreenState.transactionList[index]
                                      .category.imagePath,
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text:
                                            '${model.homeScreenState.transactionList[index].transactionsType.toString().split('.').last}: ',
                                        style: AppFonts.bodyMedium.copyWith(
                                          color: AppColors.background,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: model.homeScreenState
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
                                          .homeScreenState
                                          .transactionList[index]
                                          .date),
                                      style: AppFonts.bodyMedium.copyWith(
                                        color: AppColors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            '${model.homeScreenState.transactionList[index].transactionsType == TransactionType.income ? '+\$' : '-\$'}${model.homeScreenState.transactionList[index].amount}',
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              itemCount: model.homeScreenState.transactionList.length,
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
