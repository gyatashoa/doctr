import 'package:doctr/views/home/home_view_model.dart';
import 'package:doctr/views/home/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  bool get reactive => false;

  static const tabView = [HomeTab(), ChatTab(), DiagnosisTab(), SettingsTab()];

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold();
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
