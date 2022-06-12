import 'package:doctr/views/check_diagnosis_history/history_body_view_model.dart';
import 'package:doctr/widgets/diagnosis_expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryBodyViewModel>.reactive(
        viewModelBuilder: () => HistoryBodyViewModel(),
        builder: (_, model, child) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, i) =>
                DiagnosisExpansionWidget(data: model.data[i]),
            separatorBuilder: (_, i) => const Divider(),
            itemCount: model.data.length));
  }
}
