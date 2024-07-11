import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/components/app_text.dart';
import 'package:news_app/const/const.dart';
import 'package:news_app/models/ApiHeadlinesModel.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/views/news_headline_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  NewsViewModel newsViewModel = NewsViewModel();
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          color: Colors.red,
          text: "News App",
          font_size: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: FutureBuilder<ApiHeadlinesModel>(
        future: newsViewModel.fetchNewChannelHeadlinesApi(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitPumpingHeart(
                color: Colors.red,
                size: 50.0,
                controller: _controller,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData ||
              snapshot.data?.articles?.isEmpty == true) {
            return Center(
              child: Text("No data available"),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: AppGetScreenHeight(context) - 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.articles?.length,
                    itemBuilder: (context, index) {
                      var publishedDate = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt!);
                      var formattedDate =
                          DateFormat('d MMMM yyyy').format(publishedDate);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsHeadlineDetailsScreen(
                                        apiHeadlinesModel:
                                            snapshot.data!.articles![index],
                                      )));
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                height: AppGetScreenHeight(context) - 350,
                                width: AppGetScreenWidth(context) - 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage!,
                                    placeholder: (context, url) => Center(
                                      child: SpinKitPumpingHeart(
                                        color: Colors.red,
                                        size: 50.0,
                                        controller: _controller,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20), // Space from the bottom
                              child: Container(
                                width: AppGetScreenWidth(context) - 70,
                                height: AppGetScreenHeight(context) / 4.5,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                          fontWeight: FontWeight.bold,
                                          text: snapshot
                                              .data!.articles![index].title!,
                                          color: Colors.white,
                                          font_size: 14),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                              fontWeight: FontWeight.bold,
                                              text: snapshot.data!
                                                  .articles![index].author!,
                                              color: Colors.blue,
                                              font_size: 14),
                                          AppText(
                                              fontWeight: FontWeight.w600,
                                              text: formattedDate,
                                              color: Colors.white,
                                              font_size: 14),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
