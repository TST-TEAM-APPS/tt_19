import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/btm.dart';
import 'package:tt_25/core/colors.dart';
import 'package:tt_25/features/home/logic/view_model/home_screen_view_model.dart';
import 'package:tt_25/features/home/view/home_screen.dart';
import 'package:tt_25/features/settings/ui/settings_screen.dart';
import 'package:tt_25/features/statistics/ui/statistics_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0;

  final List<PageModel> _pages = [
    PageModel(
        page: ChangeNotifierProvider(
          create: (_) => HomeScreenViewModel(),
          child: const HomeScreen(),
        ),
        iconPath: 'assets/icons/home_screen.png',
        title: 'Home'),
    PageModel(
        page: const StatisticsScreen(),
        iconPath: 'assets/icons/statistics.png',
        title: 'Statistics'),
    PageModel(
      page: const SettingsScreen(),
      iconPath: 'assets/icons/settings.png',
      title: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex].page,
      bottomNavigationBar: WoDownBar(
        onPageChanged: (index) {
          _currentIndex = index;
          setState(() {});
        },
        pages: _pages,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 52,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_pages[index].iconPath != null)
                  Image.asset(
                    _pages[index].iconPath!,
                    color: _currentIndex == index
                        ? AppColors.green
                        : AppColors.white,
                    width: 24,
                  ),
                if (_pages[index].title != null)
                  const SizedBox(
                    height: 9,
                  ),
                if (_pages[index].title != null)
                  Text(
                    _pages[index].title!,
                    style: AppFonts.bodyMedium.copyWith(
                      color: _currentIndex == index
                          ? AppColors.green
                          : AppColors.white,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
