import 'package:doctr/app/app.locator.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class CheckUserProfileViewModel extends BaseViewModel {
  final _authService = locator<AuthServices>();

  User? get user => _authService.currentUser;
}
