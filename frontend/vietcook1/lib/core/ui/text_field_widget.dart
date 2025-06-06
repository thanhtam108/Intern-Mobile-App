import 'package:flutter/material.dart';
import 'package:vietcook1/core/configs/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? minLines;

  const CommonTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double radius = 18.0;

    OutlineInputBorder borderStyle(Color color, {double width = 1.0}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: borderStyle(Colors.grey.shade400),
        enabledBorder: borderStyle(Colors.grey.shade400),
        focusedBorder: borderStyle(AppColors.primary, width: 2.0),
        errorBorder: borderStyle(AppColors.error, width: 2.0),
        focusedErrorBorder: borderStyle(AppColors.error, width: 2.0),
        disabledBorder: borderStyle(Colors.grey.shade200),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      style: const TextStyle(fontSize: 16),
    );
  }
}
