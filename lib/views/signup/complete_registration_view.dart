import 'package:doctr/views/signup/complete_registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

class CompleteRegistrationView extends HookWidget {
  const CompleteRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // var nameController = useTextEditingController(text: '');
    // var emailController = useTextEditingController(text: '');
    // var passwordController = useTextEditingController(text: '');
    // var passwordController1 = useTextEditingController(text: '');
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<CompleteRegistrationViewModel>.nonReactive(
        viewModelBuilder: () => CompleteRegistrationViewModel(),
        builder: (_, viewModel, __) => Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: const Scaffold(),
            ));
  }
}
