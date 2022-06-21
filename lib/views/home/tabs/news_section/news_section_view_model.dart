import 'dart:developer';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/news_model.dart';
import 'package:doctr/services/api_services.dart';
import 'package:stacked/stacked.dart';

class NewsSectionViewModel extends FutureViewModel<List<NewsModel>> {
  final _apiService = locator<ApiServices>();

  @override
  Future<List<NewsModel>> futureToRun() async {
    return getNewsDataFromServer();
  }

  @override
  void onData(List<NewsModel>? data) {
    print(data);
  }

  void onRetry() {
    initialise();
  }

  Future<List<NewsModel>> getNewsDataFromServer() async {
    var res = await _apiService.getNews();
    if (res.data != null) {
      List articles = res.data['articles'];

      return articles.map((e) => NewsModel.fromJson(e)).toList();
    }
    throw res.exception!;
  }
}
