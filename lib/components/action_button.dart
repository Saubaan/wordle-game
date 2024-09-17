import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String alphabet;
  final Function(double) onTap;
  final double size;

  const ActionButton({super.key, required this.alphabet, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(size*11.6);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(size * 0.15),
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: Center(
            child: Text(
              alphabet,
              style: TextStyle(
                  fontFamily: 'RetroGame',
                  fontSize: size * 0.65,
                  color: Colors.orange.shade900),
            ),
          ),
        ),
      ),
    );
  }
}
