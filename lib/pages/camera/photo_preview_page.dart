import 'dart:io';
import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Upload Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(File(imagePath));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.darkTeal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Back Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
