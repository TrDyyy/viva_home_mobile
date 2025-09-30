import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class CustomCheckboxGroup<T> extends StatelessWidget {
  final List<CheckboxOption<T>> options;
  final List<T> values;
  final ValueChanged<List<T>> onChanged;
  final bool isVertical;

  const CustomCheckboxGroup({
    super.key,
    required this.options,
    required this.values,
    required this.onChanged,
    this.isVertical = false, 
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
    final checkboxWidgets = options.map((option) {
      final isChecked = values.contains(option.value);
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: AppSizes.icon(context, SizeCategory.medium),
            width: AppSizes.icon(context, SizeCategory.medium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSizes.radius(context, SizeCategory.xxxlarge),
              ),
              border: Border.all(color: AppColors.darkGray, width: 1),
            ),
            child: Checkbox(
              value: isChecked,
              side: BorderSide(color: AppColors.transparent),
              onChanged: (_) => _onSelected(option.value),
              activeColor: AppColors.primaryTeal,
              checkColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.radius(context, SizeCategory.medium),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          Text(
            option.label,
            style: TextStyle(
              fontSize: AppSizes.font(context, SizeCategory.large),
              fontWeight: FontWeight.w400,
              color: AppColors.darkTeal,
            ),
          ),
        ],
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isVertical)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: checkboxWidgets.map((widget) => Padding(
              padding: EdgeInsets.only(
                bottom: AppSizes.padding(context, SizeCategory.medium),
              ),
              child: widget,
            )).toList(),
          )
        else
          Wrap(
            spacing: AppSizes.padding(context, SizeCategory.medium),
            runSpacing: AppSizes.padding(context, SizeCategory.medium),
            children: checkboxWidgets,
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
