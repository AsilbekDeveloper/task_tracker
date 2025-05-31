import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class ColorSelectorWidget extends StatefulWidget {
  final Function(Color) onColorSelected;
  const ColorSelectorWidget({super.key, required this.onColorSelected});

  @override
  _ColorSelectorWidgetState createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  final List<Color> colorOptions = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.brown,
    Colors.cyanAccent,
  ];

  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: colorOptions.map((color) {
          bool isSelected = selectedColor == color;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color;
              });
              widget.onColorSelected(color);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.wPixel(6)),
              width: ResponsiveHelper.wPixel(36),
              height: ResponsiveHelper.hPixel(36),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: ResponsiveHelper.wPixel(3))
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
