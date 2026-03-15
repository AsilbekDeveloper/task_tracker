import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 3.w)
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
