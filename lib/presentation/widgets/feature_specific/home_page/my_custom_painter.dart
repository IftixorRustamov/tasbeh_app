import 'package:flutter/cupertino.dart';

class MyTasbehPainter extends CustomPainter {
  final Color circleColor;

  MyTasbehPainter({required this.circleColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = circleColor;

    final outerPath = Path()
      ..moveTo(size.width * 0.5, 0) // Center top
      ..quadraticBezierTo(
          size.width, 0, size.width, size.height * 0.2) // Top-right curve
      ..quadraticBezierTo(size.width, size.height, size.width * 0.5,
          size.height) // Right-bottom curve
      ..quadraticBezierTo(
          0, size.height, 0, size.height * 0.2) // Bottom-left curve
      ..quadraticBezierTo(0, 0, size.width * 0.5, 0) // Top-left curve
      ..close();

    canvas.drawPath(outerPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
