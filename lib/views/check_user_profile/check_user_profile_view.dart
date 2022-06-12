import 'package:doctr/views/check_user_profile/check_user_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckUserProfileView
    extends ViewModelBuilderWidget<CheckUserProfileViewModel> {
  const CheckUserProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, CheckUserProfileViewModel viewModel,
      Widget? child) {
    return const Scaffold();
  }

  @override
  CheckUserProfileViewModel viewModelBuilder(BuildContext context) =>
      CheckUserProfileViewModel();
}
