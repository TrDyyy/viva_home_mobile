import 'dart:io';
import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/use_show_image_fullscreen.dart';
import 'package:viva_home_mobile/utils/constants.dart';

class UploadImageCard extends StatelessWidget {
  final String? Function(File?)? validator;
  final void Function(File?)? onSaved;
  final Future<File?> Function()? onPickFromCamera;
  final Future<File?> Function()? onPickFromGallery;
  final void Function(bool)? onUploadStateChanged;
  final void Function()? onNodeUpdate;
  final String placeholder;

  const UploadImageCard({
    super.key,
    this.validator,
    this.onSaved,
    this.onPickFromCamera,
    this.onPickFromGallery,
    this.onUploadStateChanged,
    this.onNodeUpdate,
    this.placeholder = "upload.jpg",
  });

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      validator: validator,
      onSaved: onSaved,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Box
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.padding(
                  context,
                  SizeCategory.medium,
                ),
                vertical: AppSizes.padding(
                  context,
                  SizeCategory.large,
                ) * 0.75,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: field.hasError ? AppColors.error : AppColors.darkGray,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(
                  AppSizes.radius(
                    context,
                    SizeCategory.xxlarge,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      field.value?.path.split("/").last ?? placeholder,
                      style: TextStyle(
                        fontSize: AppSizes.font(
                          context,
                          SizeCategory.large,
                        ),
                        fontWeight: FontWeight.w400,
                        color: field.value != null
                            ? AppColors.primaryTeal
                            : AppColors.darkGray,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () async {
                      final file = await onPickFromCamera?.call();
                      if (file != null) {
                        field.didChange(file);
                        onUploadStateChanged?.call(true);
                        onNodeUpdate?.call();
                      }
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.padding(
                      context,
                      SizeCategory.small,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () async {
                      final file = await onPickFromGallery?.call();
                      if (file != null) {
                        field.didChange(file);
                        onUploadStateChanged?.call(true);
                        onNodeUpdate?.call();
                      }
                    },
                    child: const Icon(
                      Icons.upload_outlined,
                    ),
                  ),
                ],
              ),
            ),

            // Error
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.container(
                    context,
                    SizeCategory.small,
                  ) * 0.25,
                ),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: AppSizes.font(
                      context,
                      SizeCategory.medium,
                    ),
                  ),
                ),
              ),

            // Upload Success Card (preview)
            if (field.value != null) ...[
              Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.padding(
                    context,
                    SizeCategory.medium,
                  ),
                ),
                child: UploadSuccessCard(
                  fileName: field.value!.path.split("/").last,
                  imageFile: field.value,
                  onClose: () {
                    field.didChange(null);
                    onUploadStateChanged?.call(false);
                    onNodeUpdate?.call();
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

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
