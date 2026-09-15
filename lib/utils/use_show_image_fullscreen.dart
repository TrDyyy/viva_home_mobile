import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

void showImageFullScreen(
  BuildContext context, {
  required String tag,
  required ImageProvider image,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Scaffold(
        backgroundColor: AppColors.dark,
        body: Stack(
          children: [
            Center(
              child: Hero(
                tag: tag,
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Container(
                    height: AppSizes.screenHeight(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radius(context, SizeCategory.medium),
                      ),
                    ),
                    child: Image(image: image),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
