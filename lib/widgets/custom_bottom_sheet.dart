import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final double? height;
  final bool isDismissible;
  final bool enableDrag;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.height,
    this.isDismissible = true,
    this.enableDrag = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    double? height,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet(
        title: title,
        height: height,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = height ?? screenHeight * 0.6;
    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radiusLarge),
          topRight: Radius.circular(AppSizes.radiusLarge),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          if (enableDrag)
            Container(
              margin: const EdgeInsets.only(top: AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
              ),
            ),
          
          // Title
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: AppSizes.fontXXLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTeal,
                ),
              ),
            ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
