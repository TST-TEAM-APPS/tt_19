import 'package:tt_19/features/home/goals/model/goals_model.dart';

class GoalState {
  List<GoalModel> goalist;
  String totalSavings;
  GoalState({
    this.goalist = const [],
    this.totalSavings = '100',
  });
}
