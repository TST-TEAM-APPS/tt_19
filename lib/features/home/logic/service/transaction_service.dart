import 'package:hive/hive.dart';
import 'package:tt_25/features/home/logic/model/transactions_model.dart';

class TransactionService {
  List<TransactionModel> _transactionsList = [];
  List<TransactionModel> _weeklyTransactions = [];
  String _balance = '0';

  List<TransactionModel> get transactionList => _transactionsList;
  List<TransactionModel> get weeklyTransactions => _weeklyTransactions;
  String get balance => _balance;

  Future<void> loadData() async {
    final transactionModelBox =
        await Hive.openBox<TransactionModel>('_transactionsList');

    _transactionsList = transactionModelBox.values.toList();
    await getBalance();
    await getWeeklyTransactions();
  }

  Future<void> getWeeklyTransactions() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    _weeklyTransactions = _transactionsList.where((transaction) {
      return transaction.date.isAfter(sevenDaysAgo) &&
          transaction.date.isBefore(now);
    }).toList();
  }

  Future<void> addTransaction(TransactionModel trasactionModel) async {
    final transactionModelBox =
        await Hive.openBox<TransactionModel>('_transactionsList');
    await transactionModelBox.add(trasactionModel);
    await loadData();
  }

  Future<void> getBalance() async {
    final int income = _transactionsList.where((transaction) {
      return transaction.transactionsType == TransactionType.income;
    }).fold<int>(0, (sum, transaction) => sum + transaction.amount);
    final int expense = _transactionsList.where((transaction) {
      return transaction.transactionsType == TransactionType.expense;
    }).fold<int>(0, (sum, transaction) => sum + transaction.amount);

    _balance = (income - expense).toString();
  }
}
