import 'package:flutter/material.dart';
import 'constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool isLoading;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.isLoading = false,
    this.width,
    this.height,
    this.constraints,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      width: width,
      height: height,
       child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _baseButtonStyle(context).merge(style),
        child: _buildChild(context),
      ),
    );
  }

  ButtonStyle _baseButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(
          AppSizes.radius(context, SizeCategory.medium),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.padding(context, SizeCategory.large),
        vertical: AppSizes.padding(context, SizeCategory.medium),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: AppSizes.icon(context, SizeCategory.medium),
        height: AppSizes.icon(context, SizeCategory.medium),
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkTeal),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: AppSizes.font(context, SizeCategory.large),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}