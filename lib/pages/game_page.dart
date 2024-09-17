import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:wordle/components/action_button.dart';
import 'package:wordle/components/game_over_popup.dart';
import 'package:wordle/components/game_won_popup.dart';
import 'package:wordle/components/letter_box.dart';
import 'package:wordle/components/key_button.dart';

class GamePage extends StatefulWidget {
  final String word;
  final int duration;

  const GamePage({super.key, required this.word, required this.duration});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String inputWord = '';
  int currentRow = 0;
  List<String> wordRows = ['', '', '', '', '', ''];
  Random random = Random();
  List<String> usedLetters = [];
  final CountDownController countDownController = CountDownController();
  bool isRunning = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final keySize = screenWidth / 11.6;
    if (widget.duration != 0 && inputWord.isNotEmpty && !isRunning) {
      countDownController.start();
      isRunning = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Wordle",
          style: TextStyle(fontFamily: 'RetroGame', fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // debug purpose text widget
            // Text('${widget.word}  $inputWord'),
            // timer
            widget.duration == 0
                ? Container()
                : CircularCountDownTimer(
                    duration: widget.duration,
                    controller: countDownController,
                    width: screenWidth / 8,
                    height: screenHeight / 15,
                    ringColor: Colors.grey[300]!,
                    fillColor: Colors.orangeAccent,
                    backgroundColor: Colors.white54,
                    textStyle: TextStyle(
                      fontSize: screenWidth / 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    autoStart: false,
                    isReverse: true,
                    onComplete: () {
                      setState(() {
                        // countdown completes
                      });
                      _showGameOverPopup();
                    },
                  ),
            Center(
              child: Column(
                children: getWordRows(screenWidth),
              ),
            ),
            Column(
              children: [
                buildKeyboardRow(
                    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
                    keySize),
                buildKeyboardRow(
                    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'], keySize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildKeyboardRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M'], keySize),
                    ActionButton(
                      alphabet: "Del",
                      onTap: popAlphabet,
                      size: keySize,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
    } else if (word.isEmpty) {
      for (int i = 0; i < 6; i++) {
        letterBoxes.add(LetterBox(
          letter: inputWord[i],
          color: const Color.fromARGB(150, 255, 255, 255),
        ));
      }
    } else {
      List<String> charList = widget.word.split('');
      for (int i = 0; i < 6; i++) {
        if (inputWord[i] == widget.word[i]) {
          charList.remove(inputWord[i]);
        }
      }
      for (int i = 0; i < 6; i++) {
        if (inputWord[i] == widget.word[i]) {
          letterBoxes.add(LetterBox(
            letter: inputWord[i],
            color: Colors.green,
          ));
        } else if (charList.contains(inputWord[i])) {
          letterBoxes.add(LetterBox(
            letter: inputWord[i],
            color: Colors.orange,
          ));
          charList.remove(inputWord[i]);
        } else {
          letterBoxes.add(LetterBox(
            letter: inputWord[i],
            color: const Color.fromARGB(205, 119, 119, 119),
          ));
        }
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letterBoxes,
    );
  }

  List<Widget> getWordRows(double screenWidth) {
    List<Widget> rows = [];
    for (int i = 0; i < wordRows.length; i++) {
      if (currentRow == i) {
        rows.add(buildWordRow(inputWord, true, screenWidth));
      } else {
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
                  isUsed: usedLetters.contains(alphabet),
                  isCorrect: widget.word.contains(alphabet),
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
    if (inputWord.length == 6 && currentRow < wordRows.length) {
      setState(() {
        for (int i = 0; i < inputWord.length; i++) {
          usedLetters.add(inputWord[i]);
        }
        wordRows[currentRow] = inputWord;
        currentRow++;
        if (inputWord == widget.word) {
          _showGameWonPopup();
        } else if (currentRow > wordRows.length - 1) {
          _showGameOverPopup();
        }
        inputWord = '';
      });
    }
  }

  void _showGameWonPopup() {
    countDownController.pause();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GameWonPopUp(
          word: widget.word,
          duration: widget.duration,
        );
      },
    );
  }

  void _showGameOverPopup() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GameOverPopUp(
          word: widget.word,
          duration: widget.duration,
        );
      },
    );
  }
}
