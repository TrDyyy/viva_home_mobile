import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class CustomCheckboxGroup<T> extends StatelessWidget {
  final List<CheckboxOption<T>> options;
  final List<T> values;
  final ValueChanged<List<T>> onChanged;

  const CustomCheckboxGroup({
    super.key,
    required this.options,
    required this.values,
    required this.onChanged,
  });

  void _onSelected(T value) {
    final newValues = List<T>.from(values);
    if (newValues.contains(value)) {
      newValues.remove(value);
    } else {
      newValues.add(value);
    }
    onChanged(newValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: options.map((option) {
            final isChecked = values.contains(option.value);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (_) => _onSelected(option.value),
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

class CheckboxOption<T> {
  final T value;
  final String label;

  const CheckboxOption({required this.value, required this.label});
}
