import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/goals/model/goals_model.dart';

class GoalSavingsListScreen extends StatefulWidget {
  final GoalModel currentModel;
  const GoalSavingsListScreen({super.key, required this.currentModel});

  @override
  State<GoalSavingsListScreen> createState() => _GoalSavingsListScreenState();
}

class _GoalSavingsListScreenState extends State<GoalSavingsListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const _AppBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.currentModel.savingModel.isEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Add your first saving to start the goal',
                              style: AppFonts.bodyLarge.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/no-savings.png',
                              height: 200,
                              width: 200,
                            ),
                            const SizedBox()
                          ],
                        ),
                      ),
                    ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.green,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.currentModel.name,
                                        style: AppFonts.bodyMedium.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      Text(
                                        '\$${widget.currentModel.savingModel[index].savingAmount}',
                                        style: AppFonts.bodyMedium.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatTransactionDateWithoutTime(widget
                                            .currentModel
                                            .savingModel[index]
                                            .createdDate),
                                        style: AppFonts.bodyMedium.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: widget.currentModel.savingModel.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTransactionDateWithoutTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      return DateFormat('MMM. d').format(date);
    }
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();
  @override
  Widget build(BuildContext context) {
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
          'Savings history',
          style: AppFonts.displayMedium.copyWith(color: AppColors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(
          height: 24,
          width: 24,
        )
      ],
    );
  }
}
