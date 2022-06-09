import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/config/app_properties.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/symtoms_state_service.dart';
import 'package:doctr/theme/app_theme.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:doctr/views/home/home_view.dart';
import 'package:doctr/views/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await setupLocator();
  loadSnackbarConfig();
  final authServices = locator<AuthServices>();
  final cacheService = locator<CacheServices>();
  final symptomsStateService = locator<SymptomsStateService>();
  symptomsStateService.setData = cacheService.loadSymptoms() ?? [];
  runApp(MyApp(
    authServices: authServices,
  ));
}

class MyApp extends StatelessWidget {
  final AuthServices authServices;
  const MyApp({
    Key? key,
    required this.authServices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: AppTheme.lightTheme,
      home: authServices.currentUser == null
          ? const LoginView()
          : const HomeView(),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
