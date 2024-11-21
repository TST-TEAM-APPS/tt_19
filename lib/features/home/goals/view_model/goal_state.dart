import 'package:tt_25/features/home/goals/model/goals_model.dart';

class GoalState {
  List<GoalModel> goalist;
  String totalSavings;
  GoalState({
    this.goalist = const [],
    this.totalSavings = '100',
  });
}
