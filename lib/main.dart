import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tt_19/core/colors.dart';
import 'package:tt_19/features/home/goals/model/goals_model.dart';
import 'package:tt_19/features/home/logic/model/transactions_model.dart';
import 'package:tt_19/features/home/view/splash_screen.dart';
import 'package:tt_19/services/flagsmith.dart';
import 'package:tt_19/services/locator.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(GoalModelAdapter());
  Hive.registerAdapter(SavingModelAdapter());

  await Hive.initFlutter();

  await Locator.setServices();
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<Flagsmith>().closeClient),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financo: budget manager',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      home: const SplashView(),
    );
  }
}
