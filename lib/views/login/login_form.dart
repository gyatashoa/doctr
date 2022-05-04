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
              child: Icon(
                Icons.email,
                color: Color(0xffACB1C1),
              ),
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
              child: Icon(
                Icons.lock_clock_rounded,
                color: Color(0xffACB1C1),
              ),
            ),
            Expanded(
              child: TextField(
                obscureText: viewModel.viewPassword,
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.viewPassword
                            ? Icons.remove_red_eye_rounded
                            : Icons.panorama_fish_eye,
                        color: const Color(0xffACB1C1),
                      ),
                      onPressed: () =>
                          viewModel.viewPassword = !viewModel.viewPassword,
                    )),
              ),
            ),
          ],
        ),
        const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Color(0xFF1F54D3)),
              ),
            )),
        Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: const Color(0xFF0124FB)),
                onPressed: viewModel.isLoginLoading ||
                        viewModel.isLoginwithGoogleLoading
                    ? null
                    : () => viewModel.loginPressed(),
                child: viewModel.isLoginLoading
                    ? Transform.scale(
                        scale: .3,
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))),
        Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Color(0xffACB1C1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('OR'),
            ),
            Expanded(
                child: Divider(
              thickness: 1,
              color: Color(0xffACB1C1),
            ))
          ],
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          child: TextButton.icon(
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffACB1C1)),
              onPressed:
                  viewModel.isLoginwithGoogleLoading || viewModel.isLoginLoading
                      ? null
                      : () => viewModel.loginWithGooglePressed(),
              icon: viewModel.isLoginwithGoogleLoading
                  ? const SizedBox()
                  : const Icon(Icons.facebook),
              label: viewModel.isLoginwithGoogleLoading
                  ? Transform.scale(
                      scale: .3,
                      child: const CircularProgressIndicator(),
                    )
                  : const Text(
                      'Login with Google',
                      style: TextStyle(fontSize: 16, color: Color(0xff1E2944)),
                    )),
        ),
      ],
    );
  }
}
