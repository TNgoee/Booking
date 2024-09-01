import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final dashedPath = Path();
    double distance = 0.0;
    while (distance < size.width + size.height) {
      dashedPath.addRect(Rect.fromLTWH(distance, 0, dashWidth, strokeWidth));
      distance += dashWidth + dashSpace;
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
