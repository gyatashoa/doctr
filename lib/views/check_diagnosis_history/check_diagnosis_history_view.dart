import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/check_diagnosis_history/check_diagnosis_history_view_model.dart';
import 'package:doctr/widgets/diagnosis_expansion_widget.dart';
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
    var statusViewHeight = MediaQuery.of(context).viewPadding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusViewHeight),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Diagnosis History',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        // backgroundColor: primaryColor,
        body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, i) =>
                DiagnosisExpansionWidget(data: viewModel.response[i]),
            separatorBuilder: (_, i) => const Divider(),
            itemCount: viewModel.response.length),
      ),
    );
  }

  @override
  CheckDiagnosisHistoryViewModel viewModelBuilder(BuildContext context) =>
      CheckDiagnosisHistoryViewModel();
}
