import 'package:flutter/material.dart';
import 'constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enabled: enabled,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      style: TextStyle(
        fontSize: AppSizes.font(context, SizeCategory.medium),
        color: AppColors.textDark,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: hintText,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppSizes.font(context, SizeCategory.medium),
          color: AppColors.darkGray,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.white,
        border: _buildBorder(context, AppColors.lightGray, 1),
        enabledBorder: _buildBorder(context, AppColors.lightGray, 1),
        focusedBorder: _buildBorder(context, AppColors.primaryTeal, 2),
        errorBorder: _buildBorder(context, AppColors.error, 1),
        focusedErrorBorder: _buildBorder(context, AppColors.error, 2),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.padding(context, SizeCategory.medium),
          vertical: AppSizes.padding(context, SizeCategory.large) * 0.75,
        ),
      ),
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
