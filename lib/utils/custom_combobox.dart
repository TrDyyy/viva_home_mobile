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
           return LayoutBuilder(
             builder: (context, constraints) {
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   DropdownMenu<T>(
                     initialSelection: field.value,
                     hintText: hint,
                     width: constraints.maxWidth,
                     menuHeight: AppSizes.container(
                       context,
                       SizeCategory.xxlarge,
                     ),
                     onSelected: (val) {
                       field.didChange(val);
                       if (onChanged != null) onChanged(val);
                     },
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
                       backgroundColor: WidgetStateProperty.all(
                         AppColors.lightGray,
                       ),
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
                       contentPadding: const EdgeInsets.symmetric(
                         horizontal: 12,
                         vertical: 16,
                       ),
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
                           backgroundColor: field.value == item
                               ? AppColors.lightGray
                               : AppColors.transparent,
                           side: itemLast
                               ? BorderSide.none
                               : BorderSide(color: AppColors.dark, width: 0.5),
                           textStyle: TextStyle(
                             fontSize: AppSizes.font(
                               context,
                               SizeCategory.large,
                             ),
                             fontWeight: FontWeight.w400,
                             color: AppColors.dark,
                           ),
                         ),
                       );
                     }).toList(),
                   ),
                   if (field.hasError)
                     Padding(
                       padding: EdgeInsets.only(
                         top:
                             AppSizes.container(context, SizeCategory.small) *
                             0.25,
                       ),
                       child: Text(
                         field.errorText!,
                         style: TextStyle(
                           color: AppColors.error,
                           fontSize: AppSizes.font(
                             context,
                             SizeCategory.medium,
                           ),
                         ),
                       ),
                     ),
                 ],
               );
             },
           );
         },
       );
}
