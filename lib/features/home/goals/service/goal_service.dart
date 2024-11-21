import 'package:hive/hive.dart';
import 'package:tt_25/features/home/goals/model/goals_model.dart';

class GoalService {
  List<GoalModel> _goalList = [];
  String _totalSavings = '0';

  List<GoalModel> get goalList => _goalList;

  String get totalSavings => _totalSavings;

  Future<void> loadData() async {
    final goalModelBox = await Hive.openBox<GoalModel>('_goalList');
    _goalList = goalModelBox.values.toList().reversed.toList();
  }

  Future<void> addGoal(GoalModel goalModel) async {
    final goalModelBox = await Hive.openBox<GoalModel>('_goalList');
    await goalModelBox.add(goalModel);
    await loadData();
  }

  String getTotalSavings(GoalModel model) {
    final totalSavings = model.savingModel.fold<int>(
      0,
      (innerSum, goal) => innerSum + (goal.savingAmount ?? 0),
    );

    return totalSavings.toString();
  }

  Future<void> deleteGoal(GoalModel dayGoalModel) async {
    final employeList = await Hive.openBox<GoalModel>('_goalList');
    final element =
        employeList.values.toList().singleWhere((e) => e.id == dayGoalModel.id);
    await element.delete();
    await employeList.compact();
    await loadData();
  }

  Future<void> editGoal(GoalModel goalEditModel) async {
    final goalModelBox = await Hive.openBox<GoalModel>('_goalList');
    GoalModel newMoaqw =
        goalModelBox.values.singleWhere((e) => e.id == goalEditModel.id);

    newMoaqw.name = goalEditModel.name;
    newMoaqw.color = goalEditModel.color;
    newMoaqw.endingDate = goalEditModel.endingDate;
    newMoaqw.goalAmount = goalEditModel.goalAmount;
    newMoaqw.imagePath = goalEditModel.imagePath;
    newMoaqw.savingModel = goalEditModel.savingModel;

    await newMoaqw.save();
    await loadData();
  }
}
