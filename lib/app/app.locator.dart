// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_services.dart';
import '../services/auth_services.dart';
import '../services/cache_service.dart';
import '../services/cloud_firestore_services.dart';
import '../services/diagnosis_response_state_service.dart';
import '../services/symtoms_state_service.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => ApiServices());
  final cacheServices = await CacheServices.presolve();
  locator.registerSingleton(cacheServices);

  locator.registerLazySingleton(() => CloudFirestoreServices());
  locator.registerLazySingleton(() => DiagnosisResponseStateService());
  locator.registerLazySingleton(() => SymptomsStateService());
}
