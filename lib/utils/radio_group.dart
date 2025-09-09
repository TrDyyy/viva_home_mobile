import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final List<RadioOption<T>> options;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  const CustomRadioGroup({
    Key? key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  value: option.value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  activeColor: AppColors.primaryTeal,
                ),
                Text(
                  option.label,
                  style: TextStyle(
                    fontSize: AppSizes.font(context, SizeCategory.large),
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkTeal,
                  ),
                ),
                SizedBox(width: AppSizes.padding(context, SizeCategory.medium)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class RadioOption<T> {
  final T value;
  final String label;

  const RadioOption({required this.value, required this.label});
}
