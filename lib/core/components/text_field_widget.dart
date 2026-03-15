import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 48.h,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        keyboardType: widget.inputType,
        style: AppTextStyles.bodyLarge.copyWith(
          color: colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: colorScheme.surface,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.text,
          labelStyle: AppTextStyles.bodyLarge.copyWith(color: colorScheme.onSurface),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: colorScheme.onSurface)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
            onTap: widget.onSuffixTap,
            child: Icon(widget.suffixIcon, color: colorScheme.onSurface),
          )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
