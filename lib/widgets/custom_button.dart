import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final String? buttonKey;
  final BoxConstraints? constraints;

  const CustomButton({
    super.key,
    required this.text,
    required this.buttonKey,
    this.onPressed,
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
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: _buildChild(),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (buttonKey) {
      case "welcomepage":
        return _welcomePageStyle();
      case "loginpage":
        return _loginPageStyle();
      default:
        return _defaultStyle();
    }
  }

  ButtonStyle _baseButtonStyle({
    required Color backgroundColor,
    required Color textColor,
    BorderSide? borderSide,
    double elevation = 0,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      elevation: elevation,
      side: borderSide,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
    );
  }

  ButtonStyle _welcomePageStyle() {
    return _baseButtonStyle(
      backgroundColor: AppColors.white,
      textColor: AppColors.darkTeal,
    );
  }

  ButtonStyle _loginPageStyle() {
    return _baseButtonStyle(
      backgroundColor: AppColors.darkTeal,
      textColor: AppColors.white,
      elevation: 2,
    );
  }

  ButtonStyle _defaultStyle() {
    return _baseButtonStyle(
      backgroundColor: AppColors.white,
      textColor: AppColors.textDark,
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            buttonKey == "welcomepage" ? AppColors.darkTeal : AppColors.white,
          ),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: AppSizes.fontLarge,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
