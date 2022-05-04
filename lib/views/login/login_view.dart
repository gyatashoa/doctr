import 'package:doctr/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends ViewModelBuilderWidget<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ChangeNotifier viewModel, Widget? child) {
    return const Scaffold();
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
