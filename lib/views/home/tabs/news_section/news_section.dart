import 'package:doctr/views/home/tabs/news_section/news_section_view_model.dart';
import 'package:doctr/widgets/new_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({
    Key? key,
  }) : super(key: key);
  // final List<NewsModel> news;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    // print(devSize.height * .3);
    return ViewModelBuilder<NewsSectionViewModel>.reactive(
      builder: (context, model, _) {
        if (model.isBusy) {
          return SizedBox(
            height: devSize.height * .3,
            width: double.infinity,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: null,
                itemBuilder: (_, i) => const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
                      child: NewsTile.loading(),
                    )),
          );
        }

        if (model.data != null) {
          return SizedBox(
            height: devSize.height * .3,
            width: double.infinity,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: model.data!.length,
                itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8.0),
                      child: NewsTile(
                        onLaunch: model.onLaunch,
                        news: model.data![i],
                      ),
                    )),
          );
        }
        if (model.hasError) {
          return SizedBox(
            height: devSize.height * .3,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Error fetching data',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: model.onRetry,
                      child: const Text('Retry'))
                ],
              ),
            ),
          );
        }
        return Container();
      },
      viewModelBuilder: () => NewsSectionViewModel(),
    );
  }
}
