import 'package:flutter/material.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';
import 'package:tt_25/features/home/logic/service/transaction_service.dart';
import 'package:tt_25/features/statistics/logic/view_model/statistic_screen_state.dart';

class StatisticScreenViewModel extends ChangeNotifier {
  final TransactionService _transactionModelService = TransactionService();

  StatisticScreenState _statisticScreenState = StatisticScreenState();

  StatisticScreenState get statisticScreenState => _statisticScreenState;
  StatisticScreenViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    await _transactionModelService.loadData();
    await _transactionModelService
        .getTransactionsByType(_statisticScreenState.currentTransactionType);

    _statisticScreenState = StatisticScreenState(
      transactionList: _transactionModelService.transactionList,
      dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
      currentTransactionType: _transactionModelService.transactionType,
    );

    notifyListeners();
  }

  Future<void> onTransactionFilterByType(
      TransactionType transactionType) async {
    _transactionModelService.getTransactionsByType(transactionType).then((_) {
      _statisticScreenState = StatisticScreenState(
        transactionList: _transactionModelService.transactionList,
        dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
        currentTransactionType: _transactionModelService.transactionType,
      );
      notifyListeners();
    });
  }
}
