import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class DiagnosisExpansionWidget extends StatelessWidget {
  final DiagnosisResponseModel data;
  final void Function(DiagnosisResponseModel data) navigateToDiagnosisReport;
  const DiagnosisExpansionWidget(
      {Key? key, required this.data, required this.navigateToDiagnosisReport})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        children: data.symptoms
            .map((e) => Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Transform.rotate(
                            angle: 320,
                            child: const Icon(
                              Icons.push_pin_rounded,
                              color: primaryColor,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(e)
                      ],
                    ),
                  ),
                ))
            .toList(),
        subtitle: Text(timeago.format(data.createdAt)),
        trailing: IconButton(
            onPressed: () => navigateToDiagnosisReport(data),
            icon: const Icon(Icons.fullscreen)),
        title: Text(
          data.diseaseName,
          style: const TextStyle(color: primaryColor),
        ));
  }
}
