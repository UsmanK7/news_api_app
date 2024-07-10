import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  String text;
  double font_size;
  FontWeight fontWeight;
  Color color;
  AppText(
      {super.key,
      required this.fontWeight,
      required this.text,
      required this.color,
      required this.font_size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color, fontSize: font_size, fontWeight: fontWeight),
    );
  }
}
