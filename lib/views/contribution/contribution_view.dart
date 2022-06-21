import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/contribution/contribution_view_model.dart';
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.sick)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.medication))
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
                                                    onDeleted: () =>
                                                        model.onDeleteChip(e),
                                                    deleteIcon: const Icon(
                                                        Icons.cancel),
                                                    label: Text(e)),
                                              ))
                                          .toList(),
                                    ),
                                    // Flexible(
                                    //   child: TextButton(
                                    //       style: TextButton.styleFrom(
                                    //           backgroundColor: Colors.red),
                                    //       onPressed: () {},
                                    //       child: const Text('add symptom')),
                                    // )
                                  ],
                                )),
                          ),
                    const Divider(),
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
                                                    onDeleted: () =>
                                                        model.onDeleteChip(e),
                                                    deleteIcon: const Icon(
                                                        Icons.cancel),
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
                                onPressed: () {},
                                child: model.isBusy
                                    ? Transform.scale(
                                        scale: .3,
                                        child: const CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        'ADD A CONTRIBUTION',
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
