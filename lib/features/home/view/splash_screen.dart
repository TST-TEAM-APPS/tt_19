import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:in_app_review/in_app_review.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:tt_19/features/onb/onb_screen.dart';
import 'package:tt_19/features/settings/ui/privacy_screen.dart';
import 'package:tt_19/services/mixins/network_mixin.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with NetworkMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
    super.initState();
  }

  Future<void> _navigate() async {
    await checkConnection(
      onError: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SplashView(),
        ),
      ),
    );
    final isFirst = await IsFirstRun.isFirstRun();
    if (isFirst) {
      InAppReview.instance.requestReview();
    }

    if (canNavigate) {
      if (isFirst) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Onb(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Onb(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PrivacyScreen(),
        ),
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
