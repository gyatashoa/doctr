// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../models/diagnosis_response_model.dart';
import '../views/chat/chat_view.dart';
import '../views/check_diagnosis_history/check_diagnosis_history_view.dart';
import '../views/check_user_profile/check_user_profile_view.dart';
import '../views/diagnosis_report/diagnosis_report_view.dart';
import '../views/home/home_view.dart';
import '../views/login/login_view.dart';
import '../views/make_a_diagnosis/make_a_diagnosis_view.dart';
import '../views/signup/complete_registration_view.dart';
import '../views/signup/signup_view.dart';
import '../views/terms_and_conditions/terms_and_conditions_view.dart';

class Routes {
  static const String loginView = '/';
  static const String signUpView = '/sign-up-view';
  static const String homeView = '/home-view';
  static const String makeADiagnosisView = '/make-adiagnosis-view';
  static const String checkUserProfileView = '/check-user-profile-view';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String checkDiagnosisHistoryView =
      '/check-diagnosis-history-view';
  static const String completeRegistrationView = '/complete-registration-view';
  static const String diagnosisReportView = '/diagnosis-report-view';
  static const String chatView = '/chat-view';
  static const all = <String>{
    loginView,
    signUpView,
    homeView,
    makeADiagnosisView,
    checkUserProfileView,
    termsAndConditions,
    checkDiagnosisHistoryView,
    completeRegistrationView,
    diagnosisReportView,
    chatView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.makeADiagnosisView, page: MakeADiagnosisView),
    RouteDef(Routes.checkUserProfileView, page: CheckUserProfileView),
    RouteDef(Routes.termsAndConditions, page: TermsAndConditions),
    RouteDef(Routes.checkDiagnosisHistoryView, page: CheckDiagnosisHistoryView),
    RouteDef(Routes.completeRegistrationView, page: CompleteRegistrationView),
    RouteDef(Routes.diagnosisReportView, page: DiagnosisReportView),
    RouteDef(Routes.chatView, page: ChatView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    MakeADiagnosisView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MakeADiagnosisView(),
        settings: data,
      );
    },
    CheckUserProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CheckUserProfileView(),
        settings: data,
      );
    },
    TermsAndConditions: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const TermsAndConditions(),
        settings: data,
      );
    },
    CheckDiagnosisHistoryView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CheckDiagnosisHistoryView(),
        settings: data,
      );
    },
    CompleteRegistrationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CompleteRegistrationView(),
        settings: data,
      );
    },
    DiagnosisReportView: (data) {
      var args = data.getArgs<DiagnosisReportViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DiagnosisReportView(
          key: args.key,
          diagnosisResponseModel: args.diagnosisResponseModel,
        ),
        settings: data,
      );
    },
    ChatView: (data) {
      var args = data.getArgs<ChatViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatView(
          key: args.key,
          channel: args.channel,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DiagnosisReportView arguments holder class
class DiagnosisReportViewArguments {
  final Key? key;
  final DiagnosisResponseModel diagnosisResponseModel;
  DiagnosisReportViewArguments(
      {this.key, required this.diagnosisResponseModel});
}

/// ChatView arguments holder class
class ChatViewArguments {
  final Key? key;
  final Channel channel;
  ChatViewArguments({this.key, required this.channel});
}
