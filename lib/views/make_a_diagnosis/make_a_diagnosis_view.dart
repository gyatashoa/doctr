import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/make_a_diagnosis/make_a_diagnosis_view_model.dart';
import 'package:doctr/widgets/drop_down_form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MakeADiagnosisView
    extends ViewModelBuilderWidget<MakeADiagnosisViewModel> {
  const MakeADiagnosisView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  void onViewModelReady(MakeADiagnosisViewModel viewModel) {
    viewModel.getSymptoms();
  }

  @override
  Widget builder(
      BuildContext context, MakeADiagnosisViewModel viewModel, Widget? child) {
    var statusViewHeight = MediaQuery.of(context).viewPadding.top;
    final devSize = MediaQuery.of(context).size;
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
        ),
        backgroundColor: primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CustomDropDownFormField(
                        items: viewModel.symptoms,
                        selectedValue: viewModel.symp_1,
                        onChanged: (val) =>
                            viewModel.setSelectedValue('symp_1', val),
                      ),
                      CustomDropDownFormField(
                        items: viewModel.symptoms,
                        selectedValue: viewModel.symp_2,
                        onChanged: (val) =>
                            viewModel.setSelectedValue('symp_2', val),
                      ),
                      CustomDropDownFormField(
                        items: viewModel.symptoms,
                        selectedValue: viewModel.symp_3,
                        onChanged: (val) =>
                            viewModel.setSelectedValue('symp_3', val),
                      ),
                      CustomDropDownFormField(
                        items: viewModel.symptoms,
                        selectedValue: viewModel.symp_4,
                        onChanged: (val) =>
                            viewModel.setSelectedValue('symp_4', val),
                      ),
                      CustomDropDownFormField(
                        items: viewModel.symptoms,
                        selectedValue: viewModel.symp_5,
                        onChanged: (val) =>
                            viewModel.setSelectedValue('symp_5', val),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: viewModel.onStartDiagnosis,
                        child: viewModel.isBusy
                            ? Transform.scale(
                                scale: .3,
                                child: const CircularProgressIndicator(
                                    color: primaryColor),
                              )
                            : const Text(
                                'START DIAGNOSIS',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ))),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  MakeADiagnosisViewModel viewModelBuilder(BuildContext context) =>
      MakeADiagnosisViewModel();
}
