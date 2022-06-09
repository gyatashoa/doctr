import 'package:doctr/views/check_diagnosis_history/check_diagnosis_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckDiagnosisHistoryView
    extends ViewModelBuilderWidget<CheckDiagnosisHistoryViewModel> {
  const CheckDiagnosisHistoryView({Key? key}) : super(key: key);

  @override
  bool get reactive => false;

  @override
  Widget builder(BuildContext context, CheckDiagnosisHistoryViewModel viewModel,
      Widget? child) {
    return const Scaffold();
  }

  @override
  CheckDiagnosisHistoryViewModel viewModelBuilder(BuildContext context) =>
      CheckDiagnosisHistoryViewModel();
}
