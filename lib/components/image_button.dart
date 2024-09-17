import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String imagePath1;
  final VoidCallback onPressed;
  final double height;
  const ImageButton({
    super.key,
    required this.imagePath1,
    required this.onPressed,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Image(
        image: AssetImage(imagePath1),
        height: height,
      ),
    );
  }
}
