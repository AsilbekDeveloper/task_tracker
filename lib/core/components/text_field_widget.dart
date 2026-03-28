import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool isPassword;
  final TextInputType inputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final String? errorText;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.text,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplete,
    this.errorText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final bool isPasswordField = widget.isPassword;
    final bool showObscure = isPasswordField ? _obscure : false;

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: showObscure,
      keyboardType: widget.inputType,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onEditingComplete: widget.onEditingComplete,
      style: AppTextStyles.bodyLarge.copyWith(
        color: colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.surface,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.text,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightBorder,
        ),

        errorText: widget.errorText,
        errorStyle: AppTextStyles.labelSmall.copyWith(
          color: colorScheme.error,
        ),
        errorMaxLines: 2,

        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: colorScheme.onSurface)
            : null,

        suffixIcon: isPasswordField
            ? GestureDetector(
          onTap: () => setState(() => _obscure = !_obscure),
          child: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
        )
            : widget.suffixIcon != null
            ? GestureDetector(
          onTap: widget.onSuffixTap,
          child: Icon(
            widget.suffixIcon,
            color: colorScheme.onSurface,
          ),
        )
            : null,

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
        // Error state border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
      ),
    );
  }
}