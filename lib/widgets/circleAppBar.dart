import 'package:flutter/material.dart';

// Custom painter that creates the blue circle over the appBar
class CircleAppBar extends CustomPainter {
  CircleAppBar({required this.context});

  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    // Create painter
    final paint = Paint();

    // Set the color based of accent
    paint.color = Theme.of(context).colorScheme.primary;

    // Compute the center where the circle should be drawn
    Offset center = Offset(size.width * 0.5, 0);

    // Draw the circle
    canvas.drawCircle(center, size.width * 0.7, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
