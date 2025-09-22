import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class CustomComboBox<T> extends FormField<T> {
  CustomComboBox({
    super.key,
    required List<T> items,
    super.initialValue,
    String hint = '',
    super.onSaved,
    super.validator,
    ValueChanged<T?>? onChanged,
  }) : super(
         builder: (FormFieldState<T> field) {
           return _ComboBoxField<T>(
             field: field,
             items: items,
             hint: hint,
             onChanged: onChanged,
           );
         },
       );
}

class _ComboBoxField<T> extends StatefulWidget {
  final FormFieldState<T> field;
  final List<T> items;
  final String hint;
  final ValueChanged<T?>? onChanged;

  const _ComboBoxField({
    required this.field,
    required this.items,
    required this.hint,
    this.onChanged,
    super.key,
  });

  @override
  State<_ComboBoxField<T>> createState() => _ComboBoxFieldState<T>();
}

class _ComboBoxFieldState<T> extends State<_ComboBoxField<T>> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdown<T>.search(
              items: widget.items,
              onChanged: (T? value) {
                widget.field.didChange(value);
                widget.onChanged?.call(value);
              },
              hintText: "Please select an option",
              initialItem: widget.field.value,
              excludeSelected: false,
              decoration: CustomDropdownDecoration(
                closedFillColor: AppColors.white,
                expandedFillColor: AppColors.white,
                closedBorder: Border.all(
                  color: widget.field.hasError
                      ? AppColors.error
                      : AppColors.dark,
                  width: 0.5,
                ),
                expandedBorder: Border.all(
                  color: widget.field.hasError
                      ? AppColors.error
                      : AppColors.primaryTeal,
                  width: 1.5,
                ),
                closedBorderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radius(context, SizeCategory.small)),
                ),
                expandedBorderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.radius(context, SizeCategory.small)),
                ),
                listItemDecoration: ListItemDecoration(
                  selectedColor: AppColors.lightGray,
                  splashColor: AppColors.lightGray,
                  highlightColor: AppColors.lightGray,
                ),
                closedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryTeal,
                ),
                expandedSuffixIcon: Icon(
                  Icons.keyboard_arrow_up,
                  color: AppColors.primaryTeal,
                ),
              ),
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                final isLast = item == widget.items.last;
                final isCurrentSelected = widget.field.value == item;

                return Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.lightGray
                        : Colors.transparent,
                    border: isLast
                        ? null
                        : Border(
                            bottom: BorderSide(
                              color: AppColors.dark,
                              width: 0.5,
                            ),
                          ),
                  ),
                  child: InkWell(
                    onTap: onItemSelect,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding(
                          context,
                          SizeCategory.small,
                        ),
                        vertical: AppSizes.padding(
                          context,
                          SizeCategory.small,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                fontSize: AppSizes.font(
                                  context,
                                  SizeCategory.large,
                                ),
                                fontWeight: isCurrentSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isCurrentSelected
                                    ? AppColors.primaryTeal
                                    : AppColors.dark,
                              ),
                            ),
                          ),
                          if (isCurrentSelected)
                            Container(
                              margin: EdgeInsets.only(left: AppSizes.padding(context, SizeCategory.small)),
                              child: Icon(
                                Icons.check_circle,
                                color: AppColors.primaryTeal,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (widget.field.hasError)
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.container(context, SizeCategory.small) * 0.25,
                ),
                child: Text(
                  widget.field.errorText!,
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: AppSizes.font(context, SizeCategory.medium),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
