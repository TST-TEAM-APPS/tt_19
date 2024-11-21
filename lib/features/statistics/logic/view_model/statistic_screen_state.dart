import 'package:tt_19/features/home/logic/model/transactions_model.dart';
import 'package:tt_19/features/statistics/logic/model/date_filter_model.dart';

class StatisticScreenState {
  List<TransactionModel> transactionList;
  Map<DateTime, int> dateTimeMapHelper;
  TransactionType currentTransactionType;
  CategoryType currentCategoryType;
  DateFilterModel currentDateFilter;

  StatisticScreenState({
    this.transactionList = const [],
    this.dateTimeMapHelper = const {},
    this.currentTransactionType = TransactionType.all,
    this.currentDateFilter = DateFilterModel.allTime,
    this.currentCategoryType = CategoryType.all,
  });
}
