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
  State<CustomCameraPage> createState() => _CustomCameraPageState();
}

class _CustomCameraPageState extends State<CustomCameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  bool hasPermission = false;
  String? errorMessage;
  XFile? capturedImage;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameraStatus = await Permission.camera.request();
      final microphoneStatus = await Permission.microphone.request();
      
      if (!cameraStatus.isGranted) {
        setState(() {
          hasPermission = false;
          if (cameraStatus.isPermanentlyDenied) {
            errorMessage = 'Camera permission permanently denied. Please enable it in app settings.';
          } else {
            errorMessage = 'Camera permission is required to use this feature.';
          }
        });
        return;
      }

      setState(() {
        hasPermission = true;
        errorMessage = null;
      });
    
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        setState(() {
          errorMessage = 'No cameras available on this device.';
        });
        return;
      }

      _controller = CameraController(
        cameras![selectedCameraIndex], 
        ResolutionPreset.high,
        enableAudio: microphoneStatus.isGranted,
      );
      
      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
          errorMessage = null;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      if (mounted) {
        setState(() {
          hasPermission = false;
          isCameraInitialized = false;
          errorMessage = 'Failed to initialize camera. Please try again.';
        });
      }
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;
    
    setState(() {
      isCameraInitialized = false;
    });
    
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    final cameraDescription = cameras![selectedCameraIndex];
    
    try {
      await _controller?.dispose();
      _controller = CameraController(
        cameraDescription, 
        ResolutionPreset.high,
        enableAudio: true,
      );
      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
          errorMessage = null;
        });
      }
    } catch (e) {
      debugPrint('Error switching camera: $e');
      if (mounted) {
        setState(() {
          isCameraInitialized = false;
          errorMessage = 'Failed to switch camera. Please try again.';
        });
      }
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
    try {
      final status = await Permission.photos.request();
      if (!status.isGranted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gallery permission is required')),
        );
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          capturedImage = image;
        });
        _showPreview();
      }
    } catch (e) {
      debugPrint('Error picking from gallery: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to access gallery')),
      );
    }
  }

  Future<void> _showPreview() async {
    if (capturedImage == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoPreviewPage(imagePath: capturedImage!.path),
      ),
    );

    if (!mounted) return;
    if (result is File) {
      Navigator.pop(context, result);
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
                    child: Center(
                      child: errorMessage != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.white,
                                  size: 64,
                                ),
                                SizedBox(height: 16),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    errorMessage!,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (errorMessage!.contains('permanently denied'))
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: ElevatedButton(
                                      onPressed: () => openAppSettings(),
                                      child: Text('Open Settings'),
                                    ),
                                  ),
                                if (!hasPermission && !errorMessage!.contains('permanently'))
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: ElevatedButton(
                                      onPressed: _initializeCamera,
                                      child: Text('Grant Permission'),
                                    ),
                                  ),
                              ],
                            )
                          : CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
          ),
          if (isCameraInitialized && hasPermission) ...[
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
              child: Center(
                child: GestureDetector(
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
        ],
      ),
    );
  }
}
