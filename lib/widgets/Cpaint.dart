import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  String type;
  MyCustomPainter(this.type);
  @override
  void paint(Canvas canvas, Size size) {
    final center = type == "Sign"
        ? Offset(size.width * 1 / 3, size.height * 1 / 15)
        : type == "Report Card"
            ? Offset(size.width * 1, -size.height * 1 / 50)
            : type == "Health Report"
                ? Offset(size.width * 1, -size.height * 1 / 50)
                : Offset(size.width * 1 / 2, -size.height * 1 / 50);
    final radius = size.width * 0.7;

    final paint = Paint()
      ..color = Colors.blue[300]!
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Set to true if you want to repaint on changes
  }
}
