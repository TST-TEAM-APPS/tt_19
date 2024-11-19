import 'package:tt_25/features/home/logic/model/transactions_model.dart';

class StatisticScreenState {
  List<TransactionModel> transactionList;
  Map<DateTime, int> dateTimeMapHelper;
  TransactionType currentTransactionType;

  StatisticScreenState({
    this.transactionList = const [],
    this.dateTimeMapHelper = const {},
    this.currentTransactionType = TransactionType.income,
  });
}
