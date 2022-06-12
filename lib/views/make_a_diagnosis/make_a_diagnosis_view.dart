import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/make_a_diagnosis/add_symptoms_search_delegate.dart';
import 'package:doctr/views/make_a_diagnosis/make_a_diagnosis_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MakeADiagnosisView extends StatelessWidget {
  const MakeADiagnosisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusViewHeight = MediaQuery.of(context).viewPadding.top;
    final devSize = MediaQuery.of(context).size;
    var selected = <String>[
      'Headache',
      'Vomiting',
      'nabdshbsdfhbsdjfhbhj',
      'sdmnkjsbdfjhbsjdfhjhs'
          'Stomache',
      'shdfjshfdshsf'
    ];

    return ViewModelBuilder<MakeADiagnosisViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance!.addPostFrameCallback(
        (_) => model.onload(),
      ),
      builder: (BuildContext context, MakeADiagnosisViewModel viewModel,
          Widget? child) {
        return Padding(
          padding: EdgeInsets.only(top: statusViewHeight),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'MAKE A DIAGNOSIS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
              backgroundColor: primaryColor,
              actions: [
                IconButton(
                    onPressed: () async {
                      var res = await showSearch<String?>(
                          context: context,
                          delegate: AddSymptomsSearchDelegate(
                              symptoms: viewModel.symptoms));
                      viewModel.updateChips(res);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            // backgroundColor: primaryColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.01),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  viewModel.formatSymptoms.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Text('Empty'),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Wrap(
                                    children: viewModel.formatSymptoms
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Chip(
                                                  onDeleted: () =>
                                                      viewModel.onDeleteChip(e),
                                                  deleteIcon:
                                                      const Icon(Icons.cancel),
                                                  label: Text(e)),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              )),
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: viewModel.onStartDiagnosis,
                              child: viewModel.loading
                                  ? Transform.scale(
                                      scale: .3,
                                      child: const CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : const Text(
                                      'START DIAGNOSIS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ))),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => MakeADiagnosisViewModel(),
    );
  }
}
