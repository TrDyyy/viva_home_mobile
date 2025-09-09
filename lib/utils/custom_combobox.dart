import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class CustomComboBox<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;

  const CustomComboBox({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<T>(
          initialSelection: selectedItem,
          hintText: hint,
          width: constraints.maxWidth,
          menuHeight: AppSizes.container(context, SizeCategory.xxlarge),
          onSelected: onChanged,
          trailingIcon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primaryTeal,
          ),
          selectedTrailingIcon: const Icon(
            Icons.keyboard_arrow_up,
            color: AppColors.primaryTeal,
          ),
          showTrailingIcon: true,
          menuStyle: MenuStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(AppColors.lightGray),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(color: AppColors.dark, width: 0.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    AppSizes.radius(context, SizeCategory.small),
                  ),
                  bottomRight: Radius.circular(
                    AppSizes.radius(context, SizeCategory.small),
                  ),
                ),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  AppSizes.radius(context, SizeCategory.small),
                ),
                topRight: Radius.circular(
                  AppSizes.radius(context, SizeCategory.small),
                ),
              ),
            ),
          ),
          dropdownMenuEntries: items.map((item) {
            final itemLast = item == items.last;
            return DropdownMenuEntry<T>(
              value: item,
              label: item.toString(),
              style: MenuItemButton.styleFrom(
                backgroundColor: selectedItem == item
                    ? AppColors.lightGray
                    : AppColors.transparent,

                side: itemLast
                    ? BorderSide.none
                    : BorderSide(color: AppColors.dark, width: 0.5),
                textStyle: TextStyle(
                  fontSize: AppSizes.font(context, SizeCategory.large),
                  fontWeight: FontWeight.w400,
                  color: AppColors.dark,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
