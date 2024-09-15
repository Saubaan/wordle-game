import 'package:flutter/material.dart';
import 'package:wordle/pages/game_page.dart';

void main() {
  String word = "SHAIKH";
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamePage(word: word),
    ),
  );
}
