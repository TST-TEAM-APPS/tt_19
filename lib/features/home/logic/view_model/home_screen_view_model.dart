import 'package:flutter/material.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/model/weekly_transactions_model.dart';
import 'package:tt_25/features/home/logic/service/transaction_service.dart';
import 'package:tt_25/features/home/logic/view_model/home_screen_state.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final TransactionService _transactionModelService = TransactionService();

  HomeScreenState _homeScreenState = HomeScreenState();

  HomeScreenState get homeScreenState => _homeScreenState;
  HomeScreenViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    await _transactionModelService.loadData();

    _homeScreenState = HomeScreenState(
      transactionList: _transactionModelService.transactionList,
      weeklyTransactions: WeeklyTransactionsModel(
          transactionModelList: _transactionModelService.weeklyTransactions),
      balance: _transactionModelService.balance,
    );

    notifyListeners();
  }

  Future<void> onTransactionAdd(TransactionModel transactionModel) async {
    _transactionModelService.addTransaction(transactionModel).then((_) {
      _homeScreenState = HomeScreenState(
        transactionList: _transactionModelService.transactionList,
        weeklyTransactions: WeeklyTransactionsModel(
            transactionModelList: _transactionModelService.weeklyTransactions),
        balance: _transactionModelService.balance,
      );
    });
    notifyListeners();
  }
}
