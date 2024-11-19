import 'package:tt_25/features/home/logic/model/transactions_model.dart';

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
// double getExpense(int weekday) {
//     return transactionModelList.reduce()
//   }
}
