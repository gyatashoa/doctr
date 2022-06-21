import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/config/app_properties.dart';
import 'package:doctr/config/stream_credentials.dart';
import 'package:doctr/models/condition.dart';
import 'package:doctr/models/gender.dart';
import 'package:doctr/models/user_additional_data_model.dart';
import 'package:doctr/models/user_type.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/symtoms_state_service.dart';
import 'package:doctr/theme/app_theme.dart';
import 'package:doctr/utils/bottom_sheet_config.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:doctr/views/home/home_view.dart';
import 'package:doctr/views/login/login_view.dart';
import 'package:doctr/views/signup/complete_registration_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdditionalDataModelAdapter());
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(ConditionAdapter());
  Hive.registerAdapter(UserTypeAdapter());
  await setupLocator();
  loadSnackbarConfig();
  setupBottomSheetUi();
  final authServices = locator<AuthServices>();
  final cacheService = locator<CacheServices>();
  final symptomsStateService = locator<SymptomsStateService>();
  symptomsStateService.setData = cacheService.loadSymptoms() ?? [];
  bool isLoggedIn = false;
  UserAdditionalDataModel? userAdditionalDataModel;
  if (authServices.currentUser != null) {
    isLoggedIn = true;
    userAdditionalDataModel = await cacheService.getUserAddData();
  }
  final client = StreamChatClient(streamKey);

  runApp(MyApp(
    client: client,
    isLoggedIn: isLoggedIn,
    userAdditionalDataModel: userAdditionalDataModel,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final StreamChatClient client;
  final UserAdditionalDataModel? userAdditionalDataModel;
  const MyApp(
      {Key? key,
      required this.client,
      required this.isLoggedIn,
      required this.userAdditionalDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAdditionalDataProvider>(
            create: (_) => UserAdditionalDataProvider(userAdditionalDataModel))
      ],
      child: MaterialApp(
        title: appName,
        builder: (context, child) {
          return StreamChatCore(
            client: client,
            child: ChannelsBloc(
              child: UsersBloc(
                child: child!,
              ),
            ),
          );
        },
        theme: AppTheme.lightTheme,
        home: const CompleteRegistrationView(),
        // home: !isLoggedIn ? const LoginView() : const HomeView(),
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
      ),
    );
  }
}
