import 'dart:math';

import 'package:flutter/material.dart';

import '../pages/game_page.dart';
import '../utils/words_list.dart';

class GameOverPopUp extends StatelessWidget {
  const GameOverPopUp({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Random random = Random();
    return Center(
      child: PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Image(
            image: AssetImage('assets/components/game_over.png'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The word was',
                style: TextStyle(
                  fontSize: screenWidth/20,
                ),
              ),
              Text(
                word,
                style: TextStyle(fontSize: screenWidth/18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Image(
                    image: const AssetImage('assets/components/home.png'),
                    height: screenWidth/12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamePage(word: words[random.nextInt(words.length)].toUpperCase())));
                  },
                  child: Image(
                    image: const AssetImage('assets/components/play_again.png'),
                    height: screenWidth/12,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}