import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wordle/pages/game_page.dart';
import 'package:wordle/utils/words_list.dart';

void main() {
  Random random = Random();
  String word = words[random.nextInt(words.length)].toUpperCase();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamePage(word: word),
    ),
  );
}
