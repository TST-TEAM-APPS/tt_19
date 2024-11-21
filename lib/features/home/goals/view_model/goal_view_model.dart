import 'package:flutter/material.dart';
import 'package:tt_25/features/home/goals/model/goals_model.dart';
import 'package:tt_25/features/home/goals/service/goal_service.dart';
import 'package:tt_25/features/home/goals/view_model/goal_state.dart';

class GoalViewModel extends ChangeNotifier {
  final GoalService _goalModelService = GoalService();

  GoalState _goalState = GoalState();

  GoalState get goalState => _goalState;

  GoalViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    await _goalModelService.loadData();
    _goalState = GoalState(
      goalist: _goalModelService.goalList,
      totalSavings: _goalModelService.totalSavings,
    );
    notifyListeners();
  }

  Future<void> onGoalAdd(GoalModel goalModel) async {
    _goalModelService.addGoal(goalModel).then((_) {
      _goalState = GoalState(
        goalist: _goalModelService.goalList,
        totalSavings: _goalModelService.totalSavings,
      );
      notifyListeners();
    });
    loadData();
  }

  String getTotalSavings(GoalModel goalModel) {
    return _goalModelService.getTotalSavings(goalModel).toString();
  }

  void onDeleteGoal(GoalModel goalModel) async {
    await _goalModelService.deleteGoal(goalModel);
    _goalState = GoalState(
      goalist: _goalModelService.goalList,
    );
    notifyListeners();
  }

  Future<void> onUpdatedGoal(GoalModel fitnessGoalModel) async {
    _goalModelService.editGoal(fitnessGoalModel).then((_) {
      _goalState = GoalState(
        goalist: _goalModelService.goalList,
        totalSavings: _goalModelService.totalSavings,
      );

      notifyListeners();
    });
  }
}
