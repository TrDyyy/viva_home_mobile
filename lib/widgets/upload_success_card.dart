import 'dart:io';
import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class UploadSuccessCard extends StatelessWidget {
  final String fileName;
  final VoidCallback? onClose;
  final File? imageFile;

  const UploadSuccessCard({
    super.key,
    required this.fileName,
    this.onClose,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.padding(context, SizeCategory.medium)),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Success Icon
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload successful!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                Text(
                  fileName,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkTeal,
                  ),
                ),
              ],
            ),
          ),

          // Image Thumbnail
          if (imageFile != null) ...[
            SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                imageFile!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],

          // Close Button
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          InkWell(
            onTap: onClose,
            child: Icon(
              Icons.close,
              color: Colors.green,
              size: AppSizes.icon(context, SizeCategory.medium),
            ),
          ),
        ],
      ),
    );
  }
}
