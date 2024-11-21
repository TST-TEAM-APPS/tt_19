import 'package:flutter/material.dart';
import 'package:tt_19/features/home/logic/model/transactions_model.dart';
import 'package:tt_19/features/home/logic/service/transaction_service.dart';
import 'package:tt_19/features/statistics/logic/model/date_filter_model.dart';
import 'package:tt_19/features/statistics/logic/view_model/statistic_screen_state.dart';

class StatisticScreenViewModel extends ChangeNotifier {
  final TransactionService _transactionModelService = TransactionService();

  StatisticScreenState _statisticScreenState = StatisticScreenState();

  StatisticScreenState get statisticScreenState => _statisticScreenState;
  StatisticScreenViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    await _transactionModelService.loadData();

    _statisticScreenState = StatisticScreenState(
      transactionList: _transactionModelService.transactionList,
      dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
      currentTransactionType: _transactionModelService.transactionType,
      currentCategoryType: _transactionModelService.categoryType,
      currentDateFilter: _transactionModelService.dateFilter,
    );
    updateFilter(_transactionModelService.dateFilter,
        _transactionModelService.categoryType, TransactionType.income);

    notifyListeners();
  }

  Future<void> updateFilter(DateFilterModel dateFilter,
      CategoryType categoryType, TransactionType transactionType) async {
    _transactionModelService
        .updateFilter(dateFilter, categoryType, transactionType)
        .then((_) {
      _statisticScreenState = StatisticScreenState(
        transactionList: _transactionModelService.transactionList,
        dateTimeMapHelper: _transactionModelService.dateTimeMapHelper,
        currentTransactionType: _transactionModelService.transactionType,
        currentCategoryType: _transactionModelService.categoryType,
        currentDateFilter: _transactionModelService.dateFilter,
      );
      notifyListeners();
    });
  }
}
