import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:doctr/views/home/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  static const tabView = [HomeTab(), ChatTab(), DiagnosisTab(), SettingsTab()];

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    var statusViewHeight = MediaQuery.of(context).viewPadding.top;
    final devSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: statusViewHeight),
      child: Scaffold(
        body: IndexedStack(index: viewModel.index, children: tabView),
        backgroundColor: primaryColor,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: BottomNavigationBar(
              currentIndex: viewModel.index,
              onTap: (value) => viewModel.index = value,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medication), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
              ]),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
