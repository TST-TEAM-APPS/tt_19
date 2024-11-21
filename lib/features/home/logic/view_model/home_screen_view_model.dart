import 'package:flutter/material.dart';
import 'package:tt_25/features/home/goals/service/goal_service.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/model/weekly_transactions_model.dart';
import 'package:tt_25/features/home/logic/service/transaction_service.dart';
import 'package:tt_25/features/home/logic/view_model/home_screen_state.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final TransactionService _transactionModelService = TransactionService();
  final GoalService _goalModelService = GoalService();

  HomeScreenState _homeScreenState = HomeScreenState();

  HomeScreenState get homeScreenState => _homeScreenState;
  GoalService get goalService => _goalModelService;
  HomeScreenViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    await _transactionModelService.loadData();
    await _transactionModelService.getDividedDateByDay();
    await _goalModelService.loadData();

    _homeScreenState = HomeScreenState(
      transactionList: _transactionModelService.transactionList,
      weeklyTransactions: WeeklyTransactionsModel(
          transactionModelList: _transactionModelService.weeklyTransactions),
      dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
      balance: _transactionModelService.balance,
      goalModel: _goalModelService.goalList.isNotEmpty
          ? _goalModelService.goalList.first
          : null,
    );

    notifyListeners();
  }

  void sortDate() {
    _transactionModelService.sortDate().then((_) {
      _homeScreenState = HomeScreenState(
        transactionList: _transactionModelService.transactionList,
        weeklyTransactions: WeeklyTransactionsModel(
            transactionModelList: _transactionModelService.weeklyTransactions),
        dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
        balance: _transactionModelService.balance,
        goalModel: _goalModelService.goalList.first,
      );

      notifyListeners();
    });
  }

  Future<void> updateDate(DateTime date) async {
    await _transactionModelService.updateDate(date).then((_) {
      _homeScreenState = HomeScreenState(
        transactionList: _transactionModelService.transactionList,
        weeklyTransactions: WeeklyTransactionsModel(
            transactionModelList: _transactionModelService.weeklyTransactions),
        dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
        balance: _transactionModelService.balance,
        goalModel: _goalModelService.goalList.first,
      );

      notifyListeners();
    });
  }

  Future<void> onTransactionAdd(TransactionModel transactionModel) async {
    _transactionModelService.addTransaction(transactionModel).then((_) {
      _homeScreenState = HomeScreenState(
        transactionList: _transactionModelService.transactionList,
        dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
        weeklyTransactions: WeeklyTransactionsModel(
            transactionModelList: _transactionModelService.weeklyTransactions),
        balance: _transactionModelService.balance,
        goalModel: _goalModelService.goalList.first,
      );
      notifyListeners();
    });
  }
}
