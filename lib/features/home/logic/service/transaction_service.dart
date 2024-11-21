import 'package:hive/hive.dart';
import 'package:tt_19/features/home/logic/model/transactions_model.dart';
import 'package:tt_19/features/statistics/logic/model/date_filter_model.dart';

extension DateTimeExtensions on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class TransactionService {
  List<TransactionModel> _transactionsList = [];
  List<TransactionModel> _weeklyTransactions = [];
  String _balance = '0';
  CategoryType _selectedCategoryFilter = CategoryType.all;
  DateFilterModel _selectedDateFilter = DateFilterModel.allTime;
  DateTime? _dateTime;
  Map<DateTime, int> _dateTimeMapHelper = {};
  TransactionType _transactionType = TransactionType.all;
  TransactionType get transactionType => _transactionType;
  CategoryType get categoryType => _selectedCategoryFilter;
  DateFilterModel get dateFilter => _selectedDateFilter;

  Map<DateTime, int> get dateTimeMapHelper => _dateTimeMapHelper;
  List<TransactionModel> get transactionList => _transactionsList;
  List<TransactionModel> get weeklyTransactions => _weeklyTransactions;

  String get balance => _balance;

  Future<void> loadData() async {
    final transactionModelBox =
        await Hive.openBox<TransactionModel>('_transactionsList');
    _transactionsList = transactionModelBox.values.toList().reversed.where((e) {
      return (_selectedCategoryFilter == CategoryType.all
              ? true
              : e.category.categoryType == _selectedCategoryFilter) &&
          _getDataWithDateFilter(e.date) &&
          (_transactionType == TransactionType.all
              ? true
              : e.transactionsType == transactionType) &&
          (_dateTime == null
              ? true
              : e.date.year == _dateTime!.year &&
                  e.date.day == _dateTime!.day &&
                  e.date.month == _dateTime!.month);
    }).toList();
    await getBalance();
    await getWeeklyTransactions();
  }

  Future<void> updateFilter(DateFilterModel dateFilter,
      CategoryType categoryType, TransactionType transactionType) async {
    _selectedCategoryFilter = categoryType;
    _selectedDateFilter = dateFilter;
    _transactionType = transactionType;

    await loadData();
    _transactionsList.sort((a, b) => b.date.compareTo(a.date));
    _dateTimeMapHelper.clear();
    await getDividedDateByDay();
  }

  Future<void> sortDate() async {
    _transactionsList.sort((a, b) => b.date.compareTo(a.date));
    _dateTimeMapHelper.clear();
    await getDividedDateByDay();
  }

  Future<void> updateDate(DateTime date) async {
    _dateTime = date;
    await loadData();
    _dateTimeMapHelper.clear();
    await getDividedDateByDay();
  }

  bool _getDataWithDateFilter(DateTime date) {
    final now = DateTime.now();
    switch (_selectedDateFilter) {
      case DateFilterModel.allTime:
        return true;
      case DateFilterModel.today:
        return date.isSameDate(now);
      case DateFilterModel.yesterday:
        return date.isSameDate(now.subtract(const Duration(days: 1)));
      case DateFilterModel.lastWeek:
        final lastWeek = now.subtract(const Duration(days: 7));
        return date.isAfter(lastWeek) &&
            date.isBefore(now.add(const Duration(days: 1)));
      case DateFilterModel.lastMonth:
        final lastMonth = DateTime(now.year, now.month - 1, now.day);
        return date.isAfter(lastMonth) &&
            date.isBefore(now.add(const Duration(days: 1)));
      case DateFilterModel.lastYear:
        final lastYear = DateTime(now.year - 1, now.month, now.day);
        return date.isAfter(lastYear) &&
            date.isBefore(now.add(const Duration(days: 1)));
    }
  }

  Future<void> getWeeklyTransactions() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    _weeklyTransactions = _transactionsList.where((transaction) {
      return transaction.date.isAfter(sevenDaysAgo) &&
          transaction.date.isBefore(now);
    }).toList();
  }

  Future<void> getDividedDateByDay() async {
    for (var i = 0; i < _transactionsList.length; i++) {
      final normalizedDate = DateTime(
        _transactionsList[i].date.year,
        _transactionsList[i].date.month,
        _transactionsList[i].date.day,
      );
      if (!_dateTimeMapHelper.containsKey(normalizedDate)) {
        _dateTimeMapHelper[normalizedDate] = i;
      }
    }
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
