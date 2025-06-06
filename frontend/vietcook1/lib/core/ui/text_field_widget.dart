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
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.primary, width: 1.0),
    );

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.error, width: 2.0),
    );

    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
    );

    OutlineInputBorder disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
    );
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // Áp dụng các border đã định nghĩa
        border: defaultBorder,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        disabledBorder: disabledBorder,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
