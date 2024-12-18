import 'package:hive/hive.dart';

part 'transactions_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int amount;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  String comment;
  @HiveField(5)
  TransactionType transactionsType;
  @HiveField(6)
  Category category;
  TransactionModel({
    int? id,
    required this.name,
    required this.amount,
    required this.comment,
    required this.date,
    required this.transactionsType,
    required this.category,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;
}

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
  @HiveField(2)
  all
}

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  CategoryType categoryType;
  @HiveField(1)
  String imagePath;
  Category({required this.categoryType, required this.imagePath});
}

@HiveType(typeId: 3)
enum CategoryType {
  @HiveField(0)
  main,
  @HiveField(1)
  secondary,
  @HiveField(2)
  thirdly,
  @HiveField(3)
  all,
}

extension CategoryTypeModelExtension on CategoryType {
  String get name {
    switch (this) {
      case CategoryType.main:
        return "Main";
      case CategoryType.secondary:
        return "Secondary";
      case CategoryType.thirdly:
        return "Thirdly";
      case CategoryType.all:
        return "All";
    }
  }

  static final Map<String, CategoryType> _map = {
    "Main": CategoryType.main,
    "Secondary": CategoryType.secondary,
    "Thirdly": CategoryType.thirdly,
    "All": CategoryType.all,
  };

  static CategoryType fromString(String value) {
    return _map[value] ?? (throw ArgumentError('Unknown value: $value'));
  }
}
