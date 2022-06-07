import 'package:doctr/services/api_services.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/views/home/home_view.dart';
import 'package:doctr/views/login/login_view.dart';
import 'package:doctr/views/make_a_diagnosis/make_a_diagnosis_view.dart';
import 'package:doctr/views/signup/signup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: MakeADiagnosisView)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: AuthServices),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: ApiServices)
])
class AppSetup {}
