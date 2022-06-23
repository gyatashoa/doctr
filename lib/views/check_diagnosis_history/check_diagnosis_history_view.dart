import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/check_diagnosis_history/body.dart';
import 'package:doctr/views/check_diagnosis_history/check_diagnosis_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class CheckDiagnosisHistoryView
    extends ViewModelBuilderWidget<CheckDiagnosisHistoryViewModel> {
  const CheckDiagnosisHistoryView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

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
        body: Builder(builder: (context) {
          if (viewModel.dataFromStateManager.isNotEmpty) {
            return const HistoryBody();
          }

          if (viewModel.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (viewModel.hasError) {
            return const Center(child: Text('Error'));
          }
          if (viewModel.dataReady) {
            if (viewModel.data!.isEmpty) {
              return Column(
                children: [
                  Lottie.asset('assets/animations/empty_box.json'),
                  const Text('You have no diagnosis history')
                ],
              );
            }
            return const HistoryBody();
          }
          return Container();
        }),
      ),
    );
  }

  @override
  CheckDiagnosisHistoryViewModel viewModelBuilder(BuildContext context) =>
      CheckDiagnosisHistoryViewModel();
}
