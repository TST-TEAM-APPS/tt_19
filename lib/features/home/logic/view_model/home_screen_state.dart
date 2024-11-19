import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/model/weekly_transactions_model.dart';

class HomeScreenState {
  List<TransactionModel> transactionList;
  WeeklyTransactionsModel weeklyTransactions;

  String balance;
  HomeScreenState({
    this.transactionList = const [],
    this.weeklyTransactions =
        const WeeklyTransactionsModel(transactionModelList: []),
    this.balance = '0',
  });
}
