import 'package:flutter/material.dart';
import 'package:news_app/components/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppText(
        color: Colors.red,
        text: "News App",
        font_size: 30,
        fontWeight: FontWeight.bold,
      )),
    );
  }
}
