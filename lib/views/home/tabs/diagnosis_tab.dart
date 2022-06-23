// ignore_for_file: constant_identifier_names

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/user_type.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DiagnosisTab extends ViewModelWidget<HomeViewModel> {
  const DiagnosisTab({Key? key}) : super(key: key, reactive: false);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext context, HomeViewModel model) {
    var provider = Provider.of<UserAdditionalDataProvider>(context);

    List<DiagnosisTiles> tiles = [
      DiagnosisTiles.MAKE_A_DIAGNOSIS,
      DiagnosisTiles.CHECK_DIAGNOSIS_HISTORY,
      DiagnosisTiles.REPORT_A_PROBLEM
    ];
    if (provider.getUserAddData?.userType == UserType.doctor) {
      tiles = [
        DiagnosisTiles.MAKE_A_DIAGNOSIS,
        DiagnosisTiles.CHECK_DIAGNOSIS_HISTORY,
        DiagnosisTiles.REPORT_A_PROBLEM,
        DiagnosisTiles.ADD_A_CONTRIBUTION
      ];
    }
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(color: primaryColor, boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(.25))
            ]),
            width: double.infinity,
            height: 56,
            child: const Center(
                child: Text(
              'DIAGNOSIS',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ))),
        Flexible(
            child: ListView.separated(
          itemCount: tiles.length,
          itemBuilder: (_, i) => ListTile(
            onTap: () => tiles[i].onTap(model),
            title: Text(
              tiles[i].repr(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
            color: Colors.white,
          ),
        ))
      ],
    );
  }
}

enum DiagnosisTiles {
  MAKE_A_DIAGNOSIS,
  CHECK_DIAGNOSIS_HISTORY,
  REPORT_A_PROBLEM,
  ADD_A_CONTRIBUTION
}

extension on DiagnosisTiles {
  String repr() => toString().split('.').last.replaceAll(RegExp('_'), ' ');

  void onTap(HomeViewModel model) {
    var navigationService = locator<NavigationService>();
    switch (this) {
      case DiagnosisTiles.MAKE_A_DIAGNOSIS:
        navigationService.navigateTo(Routes.makeADiagnosisView);
        break;
      case DiagnosisTiles.CHECK_DIAGNOSIS_HISTORY:
        navigationService.navigateTo(Routes.checkDiagnosisHistoryView);
        break;
      case DiagnosisTiles.REPORT_A_PROBLEM:
        model.onReportAProblem();
        break;
      case DiagnosisTiles.ADD_A_CONTRIBUTION:
        model.onAddAContribution();
        break;
    }
  }
}
