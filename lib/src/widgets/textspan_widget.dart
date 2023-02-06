import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSpanCreator extends StatelessWidget {
  const TextSpanCreator({
    super.key,
    required this.header,
    required this.content,
  });

  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          height: 1.25,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        children: [
          TextSpan(
            text: header,
            style: GoogleFonts.quattrocento(
              color: const Color(0xFF000000),
            ),
          ),
          TextSpan(
            text: content,
            style: GoogleFonts.quattrocento(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
    );
  }
}
