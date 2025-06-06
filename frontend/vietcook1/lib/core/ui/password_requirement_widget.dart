import 'package:flutter/material.dart';
import 'package:vietcook1/core/configs/app_colors.dart';

class PasswordRequirementWidget extends StatelessWidget {
  final bool hasMinLength;
  final bool hasNumber;

  const PasswordRequirementWidget({
    Key? key,
    required this.hasMinLength,
    required this.hasNumber,
  }) : super(key: key);

  Widget _buildItem(String text, bool valid) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.radio_button_unchecked,
          color: valid ? AppColors.success : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: valid ? AppColors.success : Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItem("Ít nhất 6 ký tự", hasMinLength),
        _buildItem("Có chứa số", hasNumber),
      ],
    );
  }
}
