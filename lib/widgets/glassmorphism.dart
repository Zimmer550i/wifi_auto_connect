import 'dart:ui';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class Glassmorphism extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  const Glassmorphism({super.key, required this.child, this.borderRadius = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: whiteColor.withOpacity(0.2)),
        color: whiteColor.withOpacity(0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: child,
        ),
      ),
    );
  }
}
