import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/components/app_text.dart';
import 'package:news_app/models/ApiHeadlinesModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHeadlineDetailsScreen extends StatefulWidget {
  final apiHeadlinesModel;

  NewsHeadlineDetailsScreen({super.key, required this.apiHeadlinesModel});

  @override
  State<NewsHeadlineDetailsScreen> createState() =>
      _NewsHeadlineDetailsScreenState();
}

class _NewsHeadlineDetailsScreenState extends State<NewsHeadlineDetailsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          color: Colors.red,
          text: widget.apiHeadlinesModel.author,
          font_size: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              AppText(
                  fontWeight: FontWeight.w700,
                  text: widget.apiHeadlinesModel.title,
                  color: Colors.black,
                  font_size: 25),
              SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.apiHeadlinesModel.urlToImage!,
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
              SizedBox(
                height: 10,
              ),
              AppText(
                  fontWeight: FontWeight.w500,
                  text: widget.apiHeadlinesModel.content,
                  color: Colors.black,
                  font_size: 22),
              TextButton(
                onPressed: () {
                  _launchURL(Uri.parse(widget.apiHeadlinesModel.url));
                },
                child: AppText(
                    fontWeight: FontWeight.w500,
                    text: "Read More",
                    color: Colors.blue,
                    font_size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
