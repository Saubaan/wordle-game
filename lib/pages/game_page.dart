import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/components/action_button.dart';
import 'package:wordle/components/letter_box.dart';
import '../components/key_button.dart';
import '../utils/words_list.dart';

class GamePage extends StatefulWidget {
  final String word;
  const GamePage({super.key, required this.word});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String inputWord = '';
  int currentRow = 0;
  List<String> wordRows = ['', '', '', '', ''];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final keySize = screenWidth / 11.6;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Wordle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // debug purpose text widget
            Text('${widget.word}  $inputWord'),
            Column(
              children: getWordRows(screenWidth),
            ),
            Column(
              children: [
                buildKeyboardRow(
                    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
                    keySize),
                buildKeyboardRow(
                    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], keySize),
                buildKeyboardRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M'], keySize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionButton(
                    alphabet: "Delete",
                    onTap: popAlphabet,
                    size: keySize,
                  ),
                    ActionButton(
                      alphabet: "Enter",
                      onTap: enterWord,
                      size: keySize,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWordRow(String word, bool isCurrentRow, double screenWidth) {
    String inputWord = word.padRight(6);
    List<LetterBox> letterBoxes = [];
    if (isCurrentRow) {
      for (int i = 0; i < 6; i++) {
        letterBoxes.add(LetterBox(
          letter: inputWord[i],
          color: Colors.white,
        ));
      }
      return Row(
        children: letterBoxes,
      );
    } else if (word.isEmpty) {
      for (int i = 0; i < 6; i++) {
        letterBoxes.add(LetterBox(
          letter: inputWord[i],
          color: Colors.white,
        ));
      }
      return Row(
        children: letterBoxes,
      );
    } else {
      List<String> charList = widget.word.split('');
      for (int i = 0; i < 6; i++) {
        if (charList.contains(inputWord[i])) {
          if (widget.word[i] == inputWord[i]) {
            letterBoxes.add(LetterBox(
              letter: inputWord[i],
              color: Colors.green,
              textColor: Colors.white,
            ));
            charList.remove(inputWord[i]);
          } else {
            letterBoxes.add(LetterBox(
              letter: inputWord[i],
              color: Colors.orange,
              textColor: Colors.white,
            ));
            charList.remove(inputWord[i]);
          }
        } else {
          letterBoxes.add(LetterBox(
            letter: inputWord[i],
            color: Colors.grey.shade500,
            textColor: Colors.white,
          ));
        }
      }
    }
    return Row(
      children: letterBoxes,
    );
  }

  List<Widget> getWordRows(double screenWidth){
    List<Widget> rows = [];
    for(int i = 0; i < 5; i++){
      if(currentRow == i){
        rows.add(buildWordRow(inputWord, true, screenWidth));
      }
      else{
        rows.add(buildWordRow(wordRows[i], false, screenWidth));
      }
    }
    return rows;
  }

  Widget buildKeyboardRow(List<String> alphabets, double boxSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: alphabets
          .map((alphabet) => Padding(
                padding: EdgeInsets.all(screenWidth / 240),
                child: KeyButton(
                  alphabet: alphabet,
                  pushAlphabet: pushAlphabet,
                  size: boxSize,
                ),
              ))
          .toList(),
    );
  }

  void pushAlphabet(String newAlphabet) {
    setState(() {
      if (inputWord.length < 6) {
        inputWord = inputWord + newAlphabet;
      }
    });
  }

  void popAlphabet(double action) {
    setState(() {
      if (inputWord.isNotEmpty) {
        inputWord = inputWord.substring(0, inputWord.length - 1);
      }
    });
  }

  void enterWord(double screenWidth) {
    if(inputWord.length == 6 && currentRow < wordRows.length){
      setState(() {
        wordRows[currentRow] = inputWord;
        currentRow++;
        if(inputWord == widget.word){
          _showGameWonPopup(screenWidth);
        } else if(currentRow>wordRows.length-1){
          _showGameOverPopup(screenWidth);
        }
        inputWord = '';
      });
    }
  }

  void _showGameWonPopup(double screenWidth) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
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
                    'The word was ${widget.word}',
                    style: TextStyle(
                        fontSize: screenWidth/20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Hurray!',
                    style: TextStyle(fontSize: screenWidth/18,),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      },
    );
  }

  void _showGameOverPopup(double screenWidth) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
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
                    widget.word,
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
      },
    );
  }
}
