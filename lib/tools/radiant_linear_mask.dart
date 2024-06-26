import 'package:flutter/material.dart';

// Gradient mask used for the legend icons in distribution chart

class RadiantLinearMask extends StatelessWidget {
  const RadiantLinearMask(
      {super.key,
      required this.child,
      required this.color1,
      required this.color2});
  final Widget child;
  final Color color1, color2;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [color1, color2],
      ).createShader(bounds),
      child: child,
    );
  }
}
