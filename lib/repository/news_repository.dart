import 'dart:convert';

import 'package:news_app/models/ApiHeadlinesModel.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<ApiHeadlinesModel> fetchNewChannelHeadlinesApi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=4672e7fddf534bf2b2c4a6db3f71e69e';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ApiHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }
}
