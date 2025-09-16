import 'package:flutter/material.dart';
import 'constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? hintTextEnable;
  final Color? colorBorder;
  final int? maxLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
    this.hintTextEnable = true,
    this.colorBorder,
    this.maxLines,
    this.maxLength,
  });
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      onSaved: onSaved,
      initialValue: controller?.text,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              enabled: enabled,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              focusNode: focusNode,
              maxLines: maxLines,
              maxLength: maxLength,
              style: TextStyle(
                fontSize: AppSizes.font(context, SizeCategory.medium),
                color: AppColors.textDark,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                labelText: hintTextEnable == true ? hintText : null,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: AppSizes.font(context, SizeCategory.medium),
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: AppSizes.padding(context, SizeCategory.medium),
                          right:
                              AppSizes.padding(context, SizeCategory.medium) *
                              0.75,
                        ),
                        child: prefixIcon,
                      )
                    : null,
                suffixIcon: suffixIcon,
                filled: true,
                fillColor: AppColors.white,
                enabledBorder: _buildBorder(
                  context,
                  colorBorder ?? AppColors.lightGray,
                  1,
                ),
                focusedBorder: _buildBorder(context, AppColors.primaryTeal, 2),
                errorBorder: _buildBorder(context, AppColors.error, 1),
                focusedErrorBorder: _buildBorder(context, AppColors.error, 2),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context, SizeCategory.medium),
                  vertical:
                      AppSizes.padding(context, SizeCategory.large) * 0.75,
                ),
                errorStyle: const TextStyle(height: 0),
              ),
              onChanged: (val) {
                field.didChange(val); 
                if (onChanged != null) {
                  onChanged!(val);
                }
              },
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.container(context, SizeCategory.small) * 0.25,
                ),
                child: Text(
                  field.errorText ?? "",
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

  OutlineInputBorder _buildBorder(
    BuildContext context,
    Color color,
    double width,
  ) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppSizes.radius(context, SizeCategory.medium),
      ),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
