import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String _colorToHex(Color color) {
    return '#'
        '${color.red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }

  void _copyHexToClipboard() {
    final hex = _colorToHex(_backgroundColor);
    Clipboard.setData(ClipboardData(text: hex));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('HEX $hex скопирован!')));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: ColoredBox(
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hey there',
                style: TextStyle(
                  fontSize: 32,
                  color: _getContrastingTextColor(_backgroundColor),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _copyHexToClipboard,
                child: Text(
                  _colorToHex(_backgroundColor),
                  style: TextStyle(
                    fontSize: 20,
                    color: _getContrastingTextColor(
                      _backgroundColor,
                    ).withValues(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
