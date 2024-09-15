import 'package:flutter/material.dart';

class KeyButton extends StatelessWidget {
  final String alphabet;
  final Function(String) pushAlphabet;
  final double size;

  const KeyButton(
      {super.key,
        required this.alphabet,
        required this.pushAlphabet,
        required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushAlphabet(alphabet);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(size*0.15),
          border: Border.all(color: Colors.black, width: 2),
        ),
        height: size,
        width: alphabet.length == 1?size:null,
        child: Center(
          child: Text(
            alphabet,
            style: TextStyle(fontFamily: 'RetroGame',fontSize: size*0.65, color: Colors.orange.shade900),
          ),
        ),
      ),
    );
  }
}
