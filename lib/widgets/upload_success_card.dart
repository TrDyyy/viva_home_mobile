import 'dart:io';
import 'package:flutter/material.dart';
import 'package:viva_home_mobile/hooks/use_show_image_fullscreen.dart';
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
        color: AppColors.transparent,
        border: Border.all(color: AppColors.primaryTeal),
        borderRadius: BorderRadius.circular(AppSizes.radius(context, SizeCategory.medium)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Success Icon
              Icon(
                Icons.check_circle,
                color: AppColors.primaryTeal,
                size: AppSizes.icon(context, SizeCategory.medium),
              ),
              SizedBox(width: AppSizes.padding(context, SizeCategory.small)),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload successful!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTeal,
                        fontSize: AppSizes.font(context, SizeCategory.medium),
                      ),
                    ),
                    Text(
                      fileName,
                      style: TextStyle(fontSize: AppSizes.font(context, SizeCategory.small), color: AppColors.darkTeal),
                    ),
                  ],
                ),
              ),

              // Image Thumbnail
              if (imageFile != null) ...[
                SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
                Stack(
                  children: [
                    Container(
                      width:
                          AppSizes.container(context, SizeCategory.small) *
                          0.75,
                      height:
                          AppSizes.container(context, SizeCategory.small) *
                          0.75,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryTeal,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radius(context, SizeCategory.small),
                        ),
                      ),
                      child: Hero(
                        tag: "form_upload_image",
                        child: Image.file(imageFile!, fit: BoxFit.contain),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: CircleAvatar(
                        radius: AppSizes.radius(context, SizeCategory.medium),
                        backgroundColor: AppColors.dark,
                        child: InkWell(
                          onTap: () => showImageFullScreen(
                            context,
                            tag: "form_upload_image",
                            image: FileImage(imageFile!),
                          ),
                          child: Icon(
                            Icons.fullscreen,
                            color: AppColors.white,
                            size: AppSizes.icon(context, SizeCategory.small),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              // Close Button
              SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
              InkWell(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  color: AppColors.primaryTeal,
                  size: AppSizes.icon(context, SizeCategory.medium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
