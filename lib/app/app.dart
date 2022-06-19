import 'package:doctr/services/api_services.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/services/diagnosis_response_state_service.dart';
import 'package:doctr/services/symtoms_state_service.dart';
import 'package:doctr/views/check_diagnosis_history/check_diagnosis_history_view.dart';
import 'package:doctr/views/check_user_profile/check_user_profile_view.dart';
import 'package:doctr/views/diagnosis_report/diagnosis_report_view.dart';
import 'package:doctr/views/home/home_view.dart';
import 'package:doctr/views/login/login_view.dart';
import 'package:doctr/views/make_a_diagnosis/make_a_diagnosis_view.dart';
import 'package:doctr/views/signup/complete_registration_view.dart';
import 'package:doctr/views/signup/signup_view.dart';
import 'package:doctr/views/terms_and_conditions/terms_and_conditions_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: SignUpView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: MakeADiagnosisView),
  MaterialRoute(page: CheckUserProfileView),
  MaterialRoute(page: TermsAndConditions),
  MaterialRoute(page: CheckDiagnosisHistoryView),
  MaterialRoute(page: CompleteRegistrationView),
  MaterialRoute(page: DiagnosisReportView)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: AuthServices),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: ApiServices),
  Presolve(classType: CacheServices, presolveUsing: CacheServices.presolve),
  LazySingleton(classType: CloudFirestoreServices),
  LazySingleton(classType: DiagnosisResponseStateService),
  LazySingleton(classType: SymptomsStateService),
  LazySingleton(classType: BottomSheetService)
])
class AppSetup {}
