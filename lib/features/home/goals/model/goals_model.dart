// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'goals_model.g.dart';

@HiveType(typeId: 4)
class GoalModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int goalAmount;
  @HiveField(3)
  List<SavingModel> savingModel;
  @HiveField(4)
  DateTime endingDate;
  @HiveField(7)
  int? color;
  @HiveField(6)
  String imagePath;
  GoalModel({
    int? id,
    required this.name,
    required this.goalAmount,
    required this.savingModel,
    required this.endingDate,
    required this.color,
    required this.imagePath,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch;

  GoalModel copyWith({
    int? id,
    String? name,
    int? goalAmount,
    List<SavingModel>? savingModel,
    DateTime? endingDate,
    int? color,
    String? imagePath,
  }) {
    return GoalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      goalAmount: goalAmount ?? this.goalAmount,
      savingModel: savingModel ?? this.savingModel,
      endingDate: endingDate ?? this.endingDate,
      color: color ?? this.color,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

@HiveType(typeId: 5)
class SavingModel {
  @HiveField(0)
  int savingAmount;
  @HiveField(1)
  DateTime createdDate;
  SavingModel({
    required this.savingAmount,
    required this.createdDate,
  });
}
