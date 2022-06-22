import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:doctr/views/home/tabs/tabs.dart';
import 'package:doctr/widgets/fade_index_stack_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stacked/stacked.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  static const tabView = [
    Positioned.fill(child: HomeTab()),
    Positioned.fill(child: ChatTab()),
    Positioned.fill(child: DiagnosisTab()),
    Positioned.fill(child: SettingsTab())
  ];

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    var statusViewHeight = MediaQuery.of(context).viewPadding.top;
    final devSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: statusViewHeight),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
              height: devSize.height,
              width: devSize.width,
              child: FadeIndexedStack(
                children: tabView,
                index: viewModel.index,
              )),
        ),
        backgroundColor: primaryColor,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: BottomNavigationBar(
              currentIndex: viewModel.index,
              onTap: (value) => viewModel.index = value,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Ionicons.chatbubbles_sharp), label: ''),
                BottomNavigationBarItem(icon: Icon(Ionicons.medkit), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
              ]),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
