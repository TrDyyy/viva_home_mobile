import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Icon(
        value ? Icons.check_box : Icons.check_box_outline_blank,
        color: value ? AppColors.primaryTeal : AppColors.darkGray,
        size: AppSizes.icon(context, SizeCategory.medium),
      ),
    );
  }
}
