import 'dart:io';
import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';

class PhotoPreviewPage extends StatelessWidget {
  final String imagePath;
  const PhotoPreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkTeal,
      appBar: AppBar(
        title: Text("ADD PHOTO", style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.darkTeal),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: AppSizes.padding(context, SizeCategory.large),
              ),
              child: Expanded(
                child: Text(
                  "Are you sure you want to upload?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.font(context, SizeCategory.large),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Image Preview
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppSizes.padding(context, SizeCategory.large),
                vertical: AppSizes.padding(context, SizeCategory.small),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppSizes.radius(context, SizeCategory.large),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dark,
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppSizes.radius(context, SizeCategory.large),
                ),
                child: Container(
                  color: AppColors.dark,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.file(File(imagePath)),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: EdgeInsets.all(
              AppSizes.padding(context, SizeCategory.medium),
            ),
            child: Column(
              children: [
                CustomButton(
                  text: "Upload",
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.darkTeal,
                  onPressed: () {
                    Navigator.of(context).pop(File(imagePath));
                  },
                ),
                SizedBox(height: AppSizes.padding(context, SizeCategory.small)),
                CustomButton(
                  text: "Back",
                  borderColor: AppColors.white,
                  backgroundColor: AppColors.transparent,
                  foregroundColor: AppColors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
