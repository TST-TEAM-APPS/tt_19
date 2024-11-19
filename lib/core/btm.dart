import 'package:flutter/material.dart';
import 'package:tt_25/core/colors.dart';

enum _Variant {
  standart,
  indicator,
}

class WoDownBar extends StatelessWidget {
  const WoDownBar({
    super.key,
    this.index = 0,
    required this.itemBuilder,
    required this.pages,
    this.onPageChanged,
  })  : _variant = _Variant.standart,
        indicatorColor = null;

  const WoDownBar.withIndicator({
    super.key,
    this.index = 0,
    required this.itemBuilder,
    this.indicatorColor,
    required this.pages,
    this.onPageChanged,
  }) : _variant = _Variant.indicator;

  final int index;
  final Color? indicatorColor;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final List<PageModel> pages;
  final void Function(int index)? onPageChanged;

  final _Variant _variant;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 74,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          left: 35,
          right: 35,
        ),
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...pages.map(
              (e) {
                return Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onHover: (bool isHovered) {
                      if (isHovered) {}
                    },
                    borderRadius: BorderRadius.circular(16),
                    highlightColor: Colors.white.withOpacity(0.5),
                    radius: 1000,
                    onTap: () => onPageChanged?.call(pages.indexOf(e)),
                    child: itemBuilder.call(context, pages.indexOf(e)),
                  ),
                );
              },
            )
          ],
        ));
  }
}

class PageModel {
  final String? iconPath;
  final String? title;
  final Widget page;
  final String? appTitle;

  PageModel({
    this.appTitle,
    this.iconPath,
    this.title,
    required this.page,
  });
}
