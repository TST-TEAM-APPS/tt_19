import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tt_19/components/custom_button.dart';
import 'package:tt_19/core/app_fonts.dart';
import 'package:tt_19/core/colors.dart';
import 'package:tt_19/features/onb/onb_pages/onb_page_widget.dart';
import 'package:tt_19/features/parent_screen/parent_screen.dart';

class Onb extends StatefulWidget {
  const Onb({super.key});

  @override
  State<Onb> createState() => _OnbState();
}

class _OnbState extends State<Onb> {
  late PageController _onbPageController;
  bool isLastPage = false;
  @override
  void initState() {
    _onbPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _onbPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/onbback.png',
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                controller: _onbPageController,
                onPageChanged: (index) {
                  setState(() => isLastPage = index == 2);
                },
                children: const [
                  OnbPageWidget(
                    image: 'assets/images/onb1.png',
                    title: 'FinanceTracker',
                    subTitle:
                        'Manage your finances with your own assistant in tracking expenses, budget planning and achieving financial goals.',
                  ),
                  OnbPageWidget(
                    image: 'assets/images/onb2.png',
                    title: 'Functions',
                    subTitle:
                        'Get recommendations based on data analysis and achieve stability and confidence in your finances.',
                  ),
                  OnbPageWidget(
                    image: 'assets/images/onb3.png',
                    title: 'Get started',
                    subTitle: 'Start controlling your finances today!',
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
                effect: const ExpandingDotsEffect(
                    dotHeight: 4, activeDotColor: Colors.white, dotWidth: 8),
                controller: _onbPageController,
                count: 3),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                title: 'Continue',
                borderRadius: BorderRadius.circular(12),
                highlightColor: AppColors.white.withOpacity(0.5),
                backgroundColor: AppColors.onPrimary,
                titleStyle:
                    AppFonts.displayMedium.copyWith(color: Colors.white),
                onTap: () {
                  if (isLastPage) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const ParentScreen()),
                        (_) => false);
                  }
                  _onbPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
