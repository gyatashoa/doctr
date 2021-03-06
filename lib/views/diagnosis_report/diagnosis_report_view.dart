import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/diagnosis_report/diagnosis_report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:fl_chart/fl_chart.dart';

class DiagnosisReportView extends HookWidget {
  final DiagnosisResponseModel diagnosisResponseModel;
  const DiagnosisReportView({Key? key, required this.diagnosisResponseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diseaseController =
        useTextEditingController(text: diagnosisResponseModel.diseaseName);
    final probController = useTextEditingController(
        text: (diagnosisResponseModel.probability * 100).toStringAsFixed(2) +
            '%');
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<DiagnosisReportViewModel>.nonReactive(
      builder: (BuildContext context, DiagnosisReportViewModel model,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Diagnosis Report'),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .08),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Scrollbar(
                thickness: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: diseaseController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Predicted Disease:',
                      ),
                    ),
                    TextField(
                      enabled: false,
                      controller: probController,
                      decoration: const InputDecoration(
                        labelText: 'Probability:',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: devSize.height * .3,
                        child: PieChart(PieChartData(sections: [
                          PieChartSectionData(
                              title: (diagnosisResponseModel.probability * 100)
                                      .toStringAsFixed(2) +
                                  '%',
                              color: diagnosisResponseModel.probability > .5
                                  ? Colors.green
                                  : Colors.red,
                              titleStyle: const TextStyle(color: Colors.white),
                              value: diagnosisResponseModel.probability * 100),
                          PieChartSectionData(
                              title: '',
                              color: Colors.white,
                              value: 100 -
                                  diagnosisResponseModel.probability * 100)
                        ])),
                      ),
                    ),
                    const Text(
                      'Prescriptions:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    diagnosisResponseModel.prescriptions.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'Please we have no prescriptions for this disease'),
                          )
                        : Wrap(
                            children: diagnosisResponseModel.prescriptions
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RawChip(
                                          avatar: const Icon(Icons.medication),
                                          label: Text(e)),
                                    ))
                                .toList(),
                          ),
                    const Text(
                      'Symptoms:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Wrap(
                      children: diagnosisResponseModel.symptoms
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: RawChip(
                                  label: Text(e),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => DiagnosisReportViewModel(),
    );
  }
}
