import 'package:doctr/models/news_model.dart';
import 'package:doctr/views/home/tabs/news_section/news_section_view_model.dart';
import 'package:doctr/widgets/new_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({Key? key, required this.news}) : super(key: key);
  final List<NewsModel> news;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    // print(devSize.height * .3);
    return ViewModelBuilder<NewsSectionViewModel>.reactive(
      builder: (context, model, _) {
        if (model.isBusy) {
          return const CircularProgressIndicator();
        }
        if (model.hasError) {
          return Column(
            children: [
              const Text('Error fetching data'),
              TextButton(onPressed: model.onRetry, child: const Text('Retry'))
            ],
          );
        }
        if (model.dataReady) {
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
                        news: model.data![i],
                      ),
                    )),
          );
        }
        return Container();
      },
      viewModelBuilder: () => NewsSectionViewModel(),
    );
  }
}
