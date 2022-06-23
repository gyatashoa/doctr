import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/news_model.dart';
import 'package:doctr/services/api_services.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsSectionViewModel extends FutureViewModel<List<NewsModel>> {
  final _apiService = locator<ApiServices>();
  final _snackbarService = locator<SnackbarService>();

  @override
  Future<List<NewsModel>> futureToRun() async {
    return getNewsDataFromServer();
  }

  @override
  void onData(List<NewsModel>? data) {
    // print(data);
  }

  void onRetry() {
    initialise();
  }

  Future<List<NewsModel>> getNewsDataFromServer() async {
    // throw Exception('error');
    var res = await _apiService.getNews();
    if (res.data != null) {
      List articles = res.data['articles'];

      return articles.map((e) => NewsModel.fromJson(e)).toList();
    }
    throw res.exception!;
  }

  void onLaunch(String url) async {
    if (!await launchUrlString(url)) {
      _snackbarService.showCustomSnackBar(
          message: 'Unable to lauch news', variant: SnackbarVariant.error);
    }
  }
}
