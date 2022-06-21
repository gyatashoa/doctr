import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/contribution/contribution_view_model.dart';
import 'package:doctr/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ContributionView extends StatelessWidget {
  const ContributionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<ContributionViewModel>.reactive(
        viewModelBuilder: () => ContributionViewModel(),
        builder: (_, model, __) => Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: model.onAdd, icon: const Icon(Icons.add)),
                ],
                centerTitle: true,
                backgroundColor: primaryColor,
                title: const Text(
                  'CONTRIBUTIONS',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              body: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: devSize.width * 0.01),
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    HeaderChip(
                        onTap: model.onAddToSpecific, headerText: 'Symptoms'),
                    const SizedBox(
                      height: 10,
                    ),
                    model.addedSymptoms.isEmpty
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
                                      children: model.addedSymptoms
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Chip(
                                                    onDeleted: () => model
                                                        .onDeleteChip(e, 0),
                                                    deleteIcon: const Icon(
                                                        Icons.cancel),
                                                    label: Text(e)),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                )),
                          ),
                    const Divider(),
                    HeaderChip(
                        onTap: model.onAddToSpecific,
                        headerText: 'Prescriptions'),
                    const SizedBox(
                      height: 10,
                    ),
                    model.addedprescriptions.isEmpty
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
                                      children: model.addedprescriptions
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Chip(
                                                    onDeleted: () => model
                                                        .onDeleteChip(e, 1),
                                                    deleteIcon: const Icon(
                                                        Icons.cancel),
                                                    label: Text(e)),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                )),
                          ),
                    const Divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    HeaderChip(
                        onTap: model.onAddToSpecific, headerText: 'Disease'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(child: Text(model.disease ?? '')),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: primaryColor),
                                onPressed:
                                    model.isBusy ? null : model.onContribute,
                                child: model.isBusy
                                    ? Transform.scale(
                                        scale: .3,
                                        child: const CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ))),
                      ),
                    ),
                  ])),
            ));
  }
}
