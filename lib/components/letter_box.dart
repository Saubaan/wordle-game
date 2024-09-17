import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  final String letter;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  const LetterBox(
      {super.key,
      required this.letter,
      this.color,
      this.textColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: screenWidth / 8,
        width: screenWidth / 8,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 2, color: borderColor==null?Colors.grey.shade500:borderColor!),
          borderRadius: BorderRadius.circular(5),

        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              color: textColor,
              fontFamily: 'RetroGame',
              fontSize: 35,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
