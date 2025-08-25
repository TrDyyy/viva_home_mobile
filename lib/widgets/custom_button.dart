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
    required Color normalBg,
    required Color pressedBg,
    required Color normalFg,
    required Color pressedFg,
    BorderSide? pressedBorder,
    double elevation = 0,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: normalBg,
      foregroundColor: normalFg,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
    ).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) return pressedBg;
        return normalBg;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) return pressedFg;
        return normalFg;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide>((states) {
        if (states.contains(WidgetState.pressed)) {
          return pressedBorder ?? BorderSide.none;
        }
        return BorderSide.none;
      }),
    );
  }

  ButtonStyle _welcomePageStyle() {
    return _baseButtonStyle(
      normalBg: AppColors.white,
      pressedBg: Colors.transparent,
      normalFg: AppColors.darkTeal,
      pressedFg: AppColors.white,
      pressedBorder: const BorderSide(color: AppColors.white, width: 2.0),
    );
  }

  ButtonStyle _loginPageStyle() {
    return _baseButtonStyle(
      normalBg: AppColors.darkTeal,
      pressedBg: AppColors.lightGray,
      normalFg: AppColors.white,
      pressedFg: AppColors.darkTeal,
      pressedBorder: const BorderSide(color: AppColors.darkTeal, width: 2.0),
      elevation: 2,
    );
  }

  ButtonStyle _defaultStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.textDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
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
