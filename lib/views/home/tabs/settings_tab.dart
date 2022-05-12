import 'package:doctr/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsTab extends ViewModelWidget<HomeViewModel> {
  const SettingsTab({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    print('object');
    return Container(
      child: Center(
        child: Text('Settings'),
      ),
    );
  }
}
