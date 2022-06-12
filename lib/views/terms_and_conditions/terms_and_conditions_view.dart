import 'package:doctr/views/terms_and_conditions/terms_and_conditions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TermsAndConditions
    extends ViewModelBuilderWidget<TermsAndConditionsViewModel> {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ChangeNotifier viewModel, Widget? child) {
    return const Scaffold();
  }

  @override
  TermsAndConditionsViewModel viewModelBuilder(BuildContext context) =>
      TermsAndConditionsViewModel();
}
