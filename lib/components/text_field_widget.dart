import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool isPassword;
  final TextInputType inputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.text,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return SizedBox(
      height: ResponsiveHelper.hPixel(48),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        keyboardType: widget.inputType,
        style: AppTextStyles.normal16,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.fillColor,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.text,
          labelStyle: AppTextStyles.inputText,
          prefixIcon:
              widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: Colors.white)
                  : null,
          suffixIcon:
              widget.suffixIcon != null
                  ? GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: Icon(widget.suffixIcon, color: Colors.white),
                  )
                  : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
        ),
      ),
    );
  }
}
