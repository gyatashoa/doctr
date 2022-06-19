import 'package:doctr/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void loadSnackbarConfig() {
  final snackBarService = locator<SnackbarService>();

  snackBarService.registerCustomSnackbarConfig(
      variant: SnackbarVariant.error,
      config: SnackbarConfig(
          snackStyle: SnackStyle.FLOATING,
          textColor: Colors.white,
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          )));

  snackBarService.registerCustomSnackbarConfig(
      variant: SnackbarVariant.success,
      config: SnackbarConfig(
          snackStyle: SnackStyle.FLOATING,
          textColor: Colors.white,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          )));
}

enum SnackbarVariant {
  success,
  error,
  warning,
  info,
  custom,
}
