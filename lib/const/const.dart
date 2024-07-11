import 'package:flutter/material.dart';

double AppGetScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double AppGetScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
