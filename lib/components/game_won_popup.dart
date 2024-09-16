import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wordle/pages/game_page.dart';
import 'package:wordle/utils/words_list.dart';

class GameWonPopUp extends StatelessWidget {
  const GameWonPopUp({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    double screenWidth =MediaQuery.of(context).size.width;
    Random random = Random();
    return Center(
      child: PopScope(
        canPop: false,
        child: AlertDialog(
          title: Image(
            image: const AssetImage('assets/components/game_won.png'),
            height: screenWidth/2.75,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The word was $word',
                style: TextStyle(
                    fontSize: screenWidth/20, fontWeight: FontWeight.bold),
              ),
              Text(
                'You Guessed it right!',
                style: TextStyle(
                  fontSize: screenWidth/20,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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