// ignore_for_file: unnecessary_this

import 'package:doctr/models/gender.dart';
import 'package:doctr/views/signup/complete_registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

class CompleteRegistrationView extends HookWidget {
  const CompleteRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    var dobController = useTextEditingController();
    // var emailController = useTextEditingController(text: '');
    // var passwordController = useTextEditingController(text: '');
    // var passwordController1 = useTextEditingController(text: '');
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<CompleteRegistrationViewModel>.reactive(
        viewModelBuilder: () => CompleteRegistrationViewModel(),
        builder: (_, viewModel, __) => Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: devSize.width * .08),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                enabled: false,
                                controller: dobController,
                                decoration: const InputDecoration(
                                    hintText: 'Date of Birth'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                var res = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2002),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2022));
                                if (res != null) {
                                  dobController.text = res.formatDate;
                                  viewModel.onDobUpdate = res;
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF3A00FF)),
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Change Date of Birth',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Gender')),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<Gender>(
                                  title: Text(Gender.MALE.name),
                                  value: Gender.MALE,
                                  groupValue: viewModel.currentGender,
                                  onChanged: viewModel.onGenderChanged),
                            ),
                            Expanded(
                              child: RadioListTile<Gender>(
                                  title: Text(Gender.FEMALE.name),
                                  value: Gender.FEMALE,
                                  groupValue: viewModel.currentGender,
                                  onChanged: viewModel.onGenderChanged),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: const Color(0xFF3A00FF)),
                                onPressed: viewModel.isBusy
                                    ? null
                                    : viewModel.onSubmit,
                                child: viewModel.isBusy
                                    ? Transform.scale(
                                        scale: .3,
                                        child: const CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white),
                                      )))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

extension on DateTime {
  String get formatDate => '${this.day} - ${this.month} - ${this.year}';
}
