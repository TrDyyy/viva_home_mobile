import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/pages/camera/photo_preview_page.dart';
import 'package:viva_home_mobile/widgets/gallery_thumbnail.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomCameraPage extends StatefulWidget {
  const CustomCameraPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomCameraPageState createState() => _CustomCameraPageState();
}

class _CustomCameraPageState extends State<CustomCameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  XFile? capturedImage;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
  final status = await Permission.camera.request();
  if (status.isGranted) {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _controller = CameraController(cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }
    }
  } else {
    debugPrint('Camera permission denied');
  }
}

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    final cameraDescription = cameras![selectedCameraIndex];
    await _controller?.dispose();
    _controller = CameraController(cameraDescription, ResolutionPreset.high);

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error switching camera: $e');
    }
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();
      setState(() {
        capturedImage = image;
      });
      _showPreview();
    } catch (e) {
      debugPrint('Error capturing photo: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        capturedImage = image;
      });
      _showPreview();
    }
  }

  void _showPreview() {
    if (capturedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PhotoPreviewPage(imagePath: capturedImage!.path),
        ),
      ).then((result) {
        if (result is File) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context, result);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
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
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: isCameraInitialized && _controller != null
                ? CameraPreview(_controller!)
                : Container(
                    color: AppColors.dark,
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Padding(
              padding: EdgeInsets.all(
                AppSizes.padding(context, SizeCategory.small),
              ),
              child: InkWell(
                onTap: _switchCamera,
                child: Icon(
                  Icons.cameraswitch_rounded,
                  color: AppColors.white,
                  size: AppSizes.icon(context, SizeCategory.large),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child:
                // Capture Button
                GestureDetector(
                  onTap: _capturePhoto,
                  child: Container(
                    width: AppSizes.container(context, SizeCategory.small),
                    height: AppSizes.container(context, SizeCategory.small),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(
                        AppSizes.padding(context, SizeCategory.small) * 0.5,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
          ),

          Positioned(
            bottom: 10,
            left: 10,
            child: Padding(
              padding: EdgeInsets.all(
                AppSizes.padding(context, SizeCategory.small),
              ),
              child: Row(
                children: [
                  GalleryThumbnail(onTap: _pickFromGallery),
                  SizedBox(
                    width: AppSizes.padding(context, SizeCategory.small),
                  ),
                  Text(
                    "Image Library",
                    style: TextStyle(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
