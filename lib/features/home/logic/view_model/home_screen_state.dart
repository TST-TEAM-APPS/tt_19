import 'package:tt_19/features/home/goals/model/goals_model.dart';
import 'package:tt_19/features/home/logic/model/transactions_model.dart';
import 'package:tt_19/features/home/logic/model/weekly_transactions_model.dart';

class HomeScreenState {
  List<TransactionModel> transactionList;
  WeeklyTransactionsModel weeklyTransactions;
  Map<DateTime, int> dateTimeMapHelper;
  GoalModel? goalModel;

  String balance;
  HomeScreenState({
    this.goalModel,
    this.transactionList = const [],
    this.dateTimeMapHelper = const {},
    this.weeklyTransactions =
        const WeeklyTransactionsModel(transactionModelList: []),
    this.balance = '0',
  });
}
