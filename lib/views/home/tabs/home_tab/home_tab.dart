import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/views/home/tabs/home_tab/home_tab_view_model.dart';
import 'package:doctr/views/home/tabs/news_section/news_section.dart';
import 'package:doctr/widgets/emoji_btn.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthServices authService = locator<AuthServices>();
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeTabViewModel>.reactive(
        viewModelBuilder: () => HomeTabViewModel(),
        builder: (_, model, child) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: devSize.width * .1),
                      child: Text(
                        'Hi ${authService.currentUser?.displayName ?? ''}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: devSize.width * .1),
                      child: _DiseaseTextField(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: devSize.width * .1),
                      child: _HowAreYouFeelingSection(
                        onFeelingFine: model.onFeelingFine,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: devSize.width * .1),
                      child: const Text(
                        'News for you',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const NewsSection()
                  ],
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: model.anim
                      ? Container(
                          height: devSize.height,
                          color: Colors.black26,
                          child: Column(
                            children: [
                              Lottie.asset('assets/animations/blushing.zip'),
                              const Text(
                                'We are very glad that your a feeling fine',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 5,
                                          color: Colors.black38,
                                          offset: Offset(1, 2))
                                    ]),
                              ),
                            ],
                          ))
                      : const SizedBox.shrink(),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: model.anim
                      ? Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: model.onClose,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )))
                      : const SizedBox.shrink(),
                )
              ],
            ),
          );
        });
  }
}

class _HowAreYouFeelingSection extends StatelessWidget {
  final VoidCallback onFeelingFine;

  const _HowAreYouFeelingSection({Key? key, required this.onFeelingFine})
      : super(key: key);

  void onSick() async {
    final dialogService = locator<DialogService>();

    final navigationService = locator<NavigationService>();
    await dialogService.showDialog(
        title: 'Not Feeling well ',
        description:
            'Its seems you are not feeling well we recommend you make a diagnosis');
    navigationService.navigateTo(Routes.makeADiagnosisView);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling today?',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EmojiButton(
                onTap: onSick, text: 'Sick', emoji: 'assets/icons/img.png'),
            EmojiButton(
                onTap: onFeelingFine,
                text: 'Neutral',
                emoji: 'assets/icons/neutral.png'),
            EmojiButton(
                onTap: onFeelingFine,
                text: 'Happy',
                emoji: 'assets/icons/smiling.png'),
          ],
        )
      ],
    );
  }
}

class _DiseaseTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Container(
      width: devSize.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xff2D84C8)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: const [
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration.collapsed(
                    hintStyle: TextStyle(color: Colors.white38),
                    hintText: 'Disease name ...'),
              ),
            ),
            InkWell(
              child: Icon(
                Ionicons.search,
                size: 18,
                color: Colors.white38,
              ),
            )
          ],
        ),
      ),
    );
  }
}
