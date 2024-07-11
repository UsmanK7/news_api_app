import 'package:news_app/models/ApiHeadlinesModel.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<ApiHeadlinesModel> fetchNewChannelHeadlinesApi() async {
    final response = await _rep.fetchNewChannelHeadlinesApi();
    return response;
  }
}
