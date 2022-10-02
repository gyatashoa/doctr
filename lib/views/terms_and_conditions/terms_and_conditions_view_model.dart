import 'package:doctr/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TermsAndConditionsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goBack() => _navigationService.back();
}
