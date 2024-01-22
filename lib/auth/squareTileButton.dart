import 'package:flutter/material.dart';

class SquareTileButton extends StatelessWidget {
  final logoPath;
  final Function()? onTap;
  const SquareTileButton(
      {super.key, required this.logoPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          logoPath,
          height: 26,
          width: 26,
        ),
      ),
    );
  }
}
