import 'package:flutter/material.dart';

class KeyButton extends StatelessWidget {
  final String alphabet;
  final Function(String) pushAlphabet;
  final double size;
  final bool isUsed;
  final bool isCorrect;

  const KeyButton(
      {super.key,
      required this.alphabet,
      required this.pushAlphabet,
      required this.size,
      required this.isUsed,
      required this.isCorrect,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushAlphabet(alphabet);
      },
      child: Container(
        decoration: BoxDecoration(
          color: getKeyColor(),
          borderRadius: BorderRadius.circular(size * 0.15),
          border: Border.all(color: Colors.orange, width: 2),
        ),
        height: size,
        width: alphabet.length == 1 ? size : null,
        child: Center(
          child: Text(
            alphabet,
            style: TextStyle(
                fontFamily: 'RetroGame',
                fontSize: size * 0.65,
                color: isUsed ? Colors.white : Colors.orange.shade900),
          ),
        ),
      ),
    );
  }

  Color getKeyColor() {
    if(isUsed){
      if (isCorrect) {
        return Colors.green;
      }
      else {
        return Colors.grey.shade600;
      }
    }
    else {
      return Colors.yellow;
    }
  }
}
