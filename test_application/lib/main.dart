import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Random Color App',
      home: RandomColorScreen(),
    );
  }
}

class RandomColorScreen extends StatefulWidget {
  const RandomColorScreen({super.key});

  @override
  State<RandomColorScreen> createState() => _RandomColorScreenState();
}

class _RandomColorScreenState extends State<RandomColorScreen> {
  static const int _maxColorValue = 255;
  Color _backgroundColor = Colors.white;

  Color _generateRandomColor() {
    final Random random = Random();

    return Color.fromARGB(
      _maxColorValue,
      random.nextInt(_maxColorValue + 1),
      random.nextInt(_maxColorValue + 1),
      random.nextInt(_maxColorValue + 1),
    );
  }

  void _changeColor() {
    setState(() {
      _backgroundColor = _generateRandomColor();
    });
  }

  static const double _brightnessThreshold = 128.0;

  Color _getContrastingTextColor(Color background) {
    final int red = (background.r * 255.0).round() & 0xff;
    final int green = (background.g * 255.0).round() & 0xff;
    final int blue = (background.b * 255.0).round() & 0xff;

    final double brightness = (red * 299 + green * 587 + blue * 114) / 1000;

    return brightness > _brightnessThreshold ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: ColoredBox(
        color: _backgroundColor,
        child: Center(
          child: Text(
            'Hey there',
            style: TextStyle(
              fontSize: 32,
              color: _getContrastingTextColor(_backgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
