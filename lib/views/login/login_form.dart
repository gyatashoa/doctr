import 'package:doctr/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginForm extends ViewModelWidget<LoginViewModel> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 8.0, right: 15),
              child: Icon(Icons.email),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Email', contentPadding: EdgeInsets.zero),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, right: 15),
              child: Icon(Icons.lock_clock_rounded),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(viewModel.viewPassword
                          ? Icons.remove_red_eye_rounded
                          : Icons.panorama_fish_eye),
                      onPressed: () =>
                          viewModel.viewPassword = !viewModel.viewPassword,
                    )),
              ),
            ),
          ],
        ),
        const Align(
            alignment: Alignment.centerRight, child: Text('Forgot Password?')),
        SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed:
                    viewModel.isLoading ? null : () => viewModel.loginPressed(),
                child: viewModel.isLoading
                    ? Transform.scale(
                        scale: .3,
                        child: CircularProgressIndicator(),
                      )
                    : Text('Login'))),
        Row(
          children: const [
            Expanded(
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('OR'),
            ),
            Expanded(child: Divider())
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.facebook),
              label: const Text('Login with Google')),
        ),
      ],
    );
  }
}
