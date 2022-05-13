import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsTab extends ViewModelWidget<HomeViewModel> {
  const SettingsTab({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    final List<SettingsTiles> tiles = [
      SettingsTiles.CHECK_USER_PROFILE,
      SettingsTiles.ABOUT_THIS_APP,
      SettingsTiles.TERMS_AND_CONDITIONS,
      SettingsTiles.NOTIFICATIONS,
      SettingsTiles.LOGOUT,
    ];
    final devSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(color: primaryColor, boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(.25))
            ]),
            width: double.infinity,
            height: 56,
            child: const Center(
                child: Text(
              'SETTINGS',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ))),
        Flexible(
            child: ListView.separated(
          itemCount: tiles.length,
          itemBuilder: (_, i) => ListTile(
            onTap: tiles[i].navigate,
            title: Text(
              tiles[i].repr(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
            color: Colors.white,
          ),
        ))
      ],
    );
  }
}

enum SettingsTiles {
  CHECK_USER_PROFILE,
  ABOUT_THIS_APP,
  TERMS_AND_CONDITIONS,
  NOTIFICATIONS,
  LOGOUT
}

extension on SettingsTiles {
  String repr() => this.toString().split('.').last.replaceAll(RegExp('_'), ' ');

  void navigate() {
    switch (this) {
      case SettingsTiles.CHECK_USER_PROFILE:
        // TODO: Handle this case.
        break;
      case SettingsTiles.ABOUT_THIS_APP:
        // TODO: Handle this case.
        break;
      case SettingsTiles.TERMS_AND_CONDITIONS:
        // TODO: Handle this case.
        break;
      case SettingsTiles.NOTIFICATIONS:
        // TODO: Handle this case.
        break;
      case SettingsTiles.LOGOUT:
        // TODO: Handle this case.
        break;
    }
  }
}
