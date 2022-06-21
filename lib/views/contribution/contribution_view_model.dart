import 'package:stacked/stacked.dart';

class ContributionViewModel extends BaseViewModel {
  Set<String> _symptoms = {};

  List<String> get addedSymptoms => _symptoms.toList();

  Set<String> _prescriptions = {};

  List<String> get addedprescriptions => _prescriptions.toList();

  onDeleteChip(String e) {}
}
