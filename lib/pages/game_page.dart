import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/components/action_button.dart';
import 'package:wordle/components/game_over_popup.dart';
import 'package:wordle/components/game_won_popup.dart';
import 'package:wordle/components/letter_box.dart';
import 'package:wordle/components/key_button.dart';

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
  List<String> usedLetters = [];
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
        letterBoxes.add(LetterBox(
          letter: inputWord[i],
        ));
      }
      for (int i = 0; i < 6; i++) {
        if(letterBoxes[i].letter == widget.word[i]){
          letterBoxes[i].color = Colors.green;
          charList.remove(letterBoxes[i].letter);
        }
      }
      for (int i = 0; i < 6; i++) {
        if(letterBoxes[i].letter != widget.word[i] && charList.contains(letterBoxes[i].letter)){
          letterBoxes[i].color = Colors.orange;
          charList.remove(letterBoxes[i].letter);
        }
        else if(letterBoxes[i].letter != widget.word[i]){
          letterBoxes[i].color = Colors.grey.shade500;
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
    if(inputWord.length == 6 && currentRow < wordRows.length){
      setState(() {
        for(int i = 0; i<inputWord.length; i++){
          usedLetters.add(inputWord[i]);
        }
        wordRows[currentRow] = inputWord;
        currentRow++;
        if(inputWord == widget.word){
          _showGameWonPopup();
        } else if(currentRow>wordRows.length-1){
          _showGameOverPopup();
        }
        inputWord = '';
      });
    }
  }

  void _showGameWonPopup() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GameWonPopUp(word: widget.word);
      },
    );
  }

  void _showGameOverPopup() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GameOverPopUp(word: widget.word);
      },
    );
  }
}