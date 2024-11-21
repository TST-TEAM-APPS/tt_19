import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/goals/view/goal_adding_screen.dart';
import 'package:tt_25/features/home/goals/view/goal_details_screen.dart';
import 'package:tt_25/features/home/goals/view_model/goal_view_model.dart';

class GoalListScreen extends StatelessWidget {
  const GoalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _AppBar(),
              SizedBox(
                height: 20,
              ),
              GoalListWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}

class GoalListWidget extends StatelessWidget {
  const GoalListWidget({super.key});

  String daysLeft(DateTime targetDate) {
    final currentDate = DateTime.now();
    final difference = targetDate.difference(currentDate).inDays;

    if (difference > 0) {
      return '$difference days left';
    } else {
      return 'The date has passed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<GoalViewModel>();
    final modelList = model.goalState.goalist;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Material(
          borderRadius: BorderRadius.circular(10),
          color: Color(modelList[index].color!),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoalDetailsScreen(
                    viewModel: model,
                    model: modelList[index],
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            highlightColor: Colors.white.withOpacity(0.5),
            child: Container(
              height: 106,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        modelList[index].imagePath,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        modelList[index].name,
                        style: AppFonts.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Expanded(child: const SizedBox()),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.background,
                        child: Container(
                          width: double.infinity,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.onPrimary,
                        child: Container(
                          width: modelList[index].goalAmount == 0
                              ? double.infinity
                              : ((MediaQuery.of(context).size.width - 60) /
                                      modelList[index].goalAmount) *
                                  int.parse(
                                      model.getTotalSavings(modelList[index])),
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${int.parse(model.getTotalSavings(modelList[index]))} / \$${modelList[index].goalAmount}',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        daysLeft(modelList[index].endingDate),
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: modelList.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final model = context.read<GoalViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          highlightColor: AppColors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: AppColors.white,
          ),
        ),
        Text(
          'Transactions',
          style: AppFonts.displayMedium.copyWith(color: AppColors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        InkWell(
          highlightColor: AppColors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GoalAddingScreen(
                  model: model,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 24,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
