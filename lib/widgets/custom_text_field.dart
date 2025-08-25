import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;

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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enabled: enabled,
      style: const TextStyle(
        fontSize: AppSizes.fontMedium,
        color: AppColors.textDark,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: hintText,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: AppSizes.fontMedium,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightGray, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightGray, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryTeal,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }
}
