import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCreator extends StatelessWidget {
  const TextCreator(
      {super.key,
      required this.text,
      required this.textSize,
      required this.isFontBold,
      required this.fontColor,
      required this.isCenter});

  final String text;
  final double textSize;
  final bool isFontBold;
  final int fontColor;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    final String font;
    if (text.contains('Met on Canvas')) {
      font = 'Tangerine';
    } else {
      font = 'Quattrocento';
    }
    return Text(
      textAlign: isCenter ? TextAlign.center : null,
      text,
      style: GoogleFonts.getFont(
        font,
        fontSize: textSize,
        fontWeight: isFontBold ? FontWeight.bold : null,
        color: Color(fontColor), //getColor(),
      ),
    );
  }
}
