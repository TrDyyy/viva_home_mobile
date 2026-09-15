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
  final bottomSheetHeight = height ?? AppSizes.screenHeight(context) * 0.6;
  return Container(
    height: bottomSheetHeight,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSizes.radius(context, SizeCategory.large)),
        topRight: Radius.circular(AppSizes.radius(context, SizeCategory.large)),
      ),
    ),
    child: Column(
      children: [
        // Drag handle
        if (enableDrag)
          Container(
            margin: EdgeInsets.only(top: AppSizes.padding(context, SizeCategory.medium)),
            width: AppSizes.padding(context, SizeCategory.large) * 1.6,
            height: AppSizes.padding(context, SizeCategory.small) * 0.5,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(
                AppSizes.radius(context, SizeCategory.small) * 0.5,
              ),
            ),
          ),
        
        // Title
        if (title != null)
          Padding(
            padding: EdgeInsets.all(AppSizes.padding(context, SizeCategory.large)),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: AppSizes.font(context, SizeCategory.xxxlarge),
                fontWeight: FontWeight.w900,
                color: AppColors.darkTeal,
              ),
            ),
          ),
        
        // Content with keyboard avoidance
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppSizes.padding(context, SizeCategory.large),
              right: AppSizes.padding(context, SizeCategory.large),
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ],
    ),
  );
}
}
