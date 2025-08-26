import 'package:flutter/material.dart';
import 'constants.dart';

/// Button style variants
enum CustomButtonStyle { primary, secondary }

/// A customizable button widget with predefined styles
///
/// This utility widget provides consistent button styling across the app
/// with primary and secondary variants, loading states, and responsive sizing.
///
/// Example usage:
/// ```dart
/// CustomButton(
///   text: 'Login',
///   style: CustomButtonStyle.primary,
///   onPressed: () => handleLogin(),
///   isLoading: isProcessing,
/// )
/// ```
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonStyle style;
  final bool isLoading;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = CustomButtonStyle.primary,
    this.isLoading = false,
    this.width,
    this.height,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      width: width,
      height: AppSizes.paddingXLarge(context) * 1.8,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(context),
        child: _buildChild(context),
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    switch (style) {
      case CustomButtonStyle.primary:
        return _primaryButtonStyle(context);
      case CustomButtonStyle.secondary:
        return _secondaryButtonStyle(context);
    }
  }

  ButtonStyle _baseButtonStyle({
    required Color backgroundColor,
    required Color textColor,
    BorderSide? borderSide,
    double elevation = 0,
    required BuildContext context,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      elevation: elevation,
      side: borderSide,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.radius(context, SizeCategory.large),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLarge(context),
        vertical: AppSizes.paddingMedium(context),
      ),
    );
  }

  ButtonStyle _primaryButtonStyle(BuildContext context) {
    return _baseButtonStyle(
      backgroundColor: AppColors.white,
      textColor: AppColors.darkTeal,
      context: context,
    );
  }

  ButtonStyle _secondaryButtonStyle(BuildContext context) {
    return _baseButtonStyle(
      backgroundColor: AppColors.darkTeal,
      textColor: AppColors.white,
      elevation: 2,
      context: context,
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: AppSizes.iconMedium(context),
        height: AppSizes.iconMedium(context),
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkTeal),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: AppSizes.fontLarge(context),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}