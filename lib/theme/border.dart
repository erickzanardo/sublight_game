import 'package:flutter/material.dart';

class SublightBorder extends ShapeBorder {
  const SublightBorder({
    required this.color,
  });

  static const borderWidth = 10.0;

  final Color color;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect..deflate(borderWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final topLeft = Path()
      ..moveTo(rect.width / 4, 0)
      ..lineTo(0, 0)
      ..lineTo(0, rect.height * 0.4);

    canvas.drawPath(
      topLeft,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth / 4,
    );

    final bottomLeft = Path()
      ..moveTo(0, rect.height * 0.4)
      ..lineTo(0, rect.height)
      ..lineTo(rect.width / 4, rect.height);

    canvas.drawPath(
      bottomLeft,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );

    final topRight = Path()
      ..moveTo(rect.width - rect.width / 4, 0)
      ..lineTo(rect.width, 0)
      ..lineTo(rect.width, rect.height * 0.4);

    canvas.drawPath(
      topRight,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );

    final bottomRight = Path()
      ..moveTo(rect.width, rect.height * 0.4)
      ..lineTo(rect.width, rect.height)
      ..lineTo(rect.width - rect.width / 4, rect.height);

    canvas.drawPath(
      bottomRight,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth / 4,
    );
  }

  @override
  ShapeBorder scale(double t) => SublightBorder(color: color);
}
