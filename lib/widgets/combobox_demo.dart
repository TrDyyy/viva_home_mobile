import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
    bool enabled = true,
  }) : super(
         builder: (FormFieldState<T> field) {
           return _CustomDropdownField<T>(
             field: field,
             items: items,
             hint: hint,
             onChanged: onChanged,
             enabled: enabled,
           );
         },
       );
}

class _CustomDropdownField<T> extends StatefulWidget {
  final FormFieldState<T> field;
  final List<T> items;
  final String hint;
  final ValueChanged<T?>? onChanged;
  final bool enabled;

  const _CustomDropdownField({
    required this.field,
    required this.items,
    required this.hint,
    this.onChanged,
    this.enabled = true,
    super.key,
  });

  @override
  State<_CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<_CustomDropdownField<T>> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth > 0 ? constraints.maxWidth : AppSizes.container(context, SizeCategory.xxxlarge),
                maxWidth: constraints.maxWidth > 0
                    ? constraints.maxWidth
                    : double.infinity,
              ),
              child: DropdownButtonFormField2<T>(
                value: widget.field.value,
                items: widget.items.map((T item) {
                  final isSelected = widget.field.value == item;
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.padding(context, SizeCategory.small) * 0.75,
                        vertical: AppSizes.padding(context, SizeCategory.small),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                fontSize: AppSizes.font(context, SizeCategory.large),
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? AppColors.primaryTeal : AppColors.dark,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              margin: EdgeInsets.only(left: AppSizes.padding(context, SizeCategory.small)),
                              child: Icon(
                                Icons.check_circle,
                                color: AppColors.primaryTeal,
                                size: AppSizes.icon(context, SizeCategory.medium),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: widget.enabled ? (T? value) {
                  widget.field.didChange(value);
                  widget.onChanged?.call(value);
                } : null,
                onMenuStateChange: (isOpen) {
                  setState(() {
                    _isMenuOpen = isOpen;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: AppSizes.container(context, SizeCategory.small) *0.85,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context, SizeCategory.medium)),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: widget.field.hasError
                          ? AppColors.error
                          : (_isMenuOpen ? AppColors.primaryTeal : AppColors.dark),
                      width: _isMenuOpen ? 1.5 : 1,
                    ),
                    
                    borderRadius: _isMenuOpen
                        ? BorderRadius.only(
                            topLeft: Radius.circular(
                              AppSizes.radius(context, SizeCategory.small),
                            ),
                            topRight: Radius.circular(
                              AppSizes.radius(context, SizeCategory.small),
                            ),
                          )
                        : BorderRadius.circular(
                            AppSizes.radius(context, SizeCategory.small),
                          ),
                  ),
                ),

                // Custom icon styling
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryTeal,
                  ),
                  openMenuIcon: Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.primaryTeal,
                  ),
                ),

                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: constraints.maxWidth > 0 ? constraints.maxWidth : null,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        AppSizes.radius(context, SizeCategory.small),
                      ),
                      bottomRight: Radius.circular(
                        AppSizes.radius(context, SizeCategory.small),
                      ),
                    ),
                    border: Border(
                      left: BorderSide(color: AppColors.primaryTeal, width: 1.5),
                      right: BorderSide(color: AppColors.primaryTeal, width: 1.5),
                      bottom: BorderSide(color: AppColors.primaryTeal, width: 1.5),
                    ),
                  ),
                  // KEY: Offset âm để dropdown "dính" vào button
                  offset: Offset(0, -1.5),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: Radius.circular(40),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),

                // Custom menu item styling
                menuItemStyleData: MenuItemStyleData(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return AppColors.primaryTeal;
                      }
                      return null;
                    },
                  ),
                ),

                // Hint
                hint: Text(
                  widget.hint,
                  style: TextStyle(
                    fontSize: AppSizes.font(context, SizeCategory.large),
                    fontWeight: FontWeight.w400,
                    color: AppColors.dark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                // Custom validator style
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorStyle: TextStyle(height: 0),
                ),

                isExpanded: true,
              ),
            ),

            // Custom error message
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        );
      },
    );
  }
}