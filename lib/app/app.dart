import 'package:doctr/services/auth_services.dart';
import 'package:doctr/views/home/home_view.dart';
import 'package:doctr/views/login/login_view.dart';
import 'package:doctr/views/signup/signup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: HomeView)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: AuthServices),
  LazySingleton(classType: DialogService)
])
class AppSetup {}
