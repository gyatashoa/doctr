import 'package:doctr/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void loadDialogConfig() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.choice: (_, req, void Function(DialogResponse<dynamic>) res) {
      return _ChoiceDialog(res: res);
    }
  };

  dialogService.registerCustomDialogBuilders(builders);
}

enum DialogType { choice }

class _ChoiceDialog extends StatelessWidget {
  final void Function(DialogResponse) res;

  const _ChoiceDialog({Key? key, required this.res}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      // title: Text('Select an option to add'),
      children: [
        TextButton(
            onPressed: () {
              res(DialogResponse(data: 0));
            },
            child: const Text('Symptoms')),
        TextButton(onPressed: () {}, child: const Text('Prescriptions')),
        TextButton(onPressed: () {}, child: const Text('Disease')),
      ],
    );
  }
}
