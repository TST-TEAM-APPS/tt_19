import 'package:tt_19/features/home/logic/model/transactions_model.dart';

class WeeklyTransactionsModel {
  final List<TransactionModel> transactionModelList;

  const WeeklyTransactionsModel({
    this.transactionModelList = const [],
  });

  double getIncome(int weekday) {
    return transactionModelList.where((transaction) {
      return transaction.transactionsType == TransactionType.income &&
          transaction.date.weekday == weekday;
    }).fold<double>(0, (sum, transaction) => sum + transaction.amount);
  }

  double getExpense(int weekday) {
    return transactionModelList.where((transaction) {
      return transaction.transactionsType == TransactionType.expense &&
          transaction.date.weekday == weekday;
    }).fold<double>(0, (sum, transaction) => sum + transaction.amount);
  }

  double getMaxAmount() {
    if (transactionModelList.isEmpty) {
      return 0;
    }

    double maxDifference = double.negativeInfinity;
    for (int weekday = 1; weekday <= 7; weekday++) {
      final income = getIncome(weekday);
      final expense = getExpense(weekday);
      final difference = income > expense ? income : expense;
      if (difference > maxDifference) {
        maxDifference = difference;
      }
    }

    return maxDifference;
  }
}
