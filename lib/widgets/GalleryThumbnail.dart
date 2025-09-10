import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryThumbnail extends StatefulWidget {
  final VoidCallback onTap;
  const GalleryThumbnail({super.key, required this.onTap});

  @override
  State<GalleryThumbnail> createState() => _GalleryThumbnailState();
}

class _GalleryThumbnailState extends State<GalleryThumbnail> {
  Uint8List? _latestImage;

  @override
  void initState() {
    super.initState();
    _loadLatestImage();
  }

  Future<void> _loadLatestImage() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth) return;

    final albums = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.image,
    );

    if (albums.isNotEmpty) {
      final recent = albums.first;
      final media = await recent.getAssetListRange(start: 0, end: 1); // lấy ảnh mới nhất
      if (media.isNotEmpty) {
        final file = await media.first.thumbnailDataWithSize(ThumbnailSize(200, 200));
        setState(() {
          _latestImage = file;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _latestImage != null
            ? Image.memory(
                _latestImage!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.photo_library, color: Colors.white, size: 40),
      ),
    );
  }
}
