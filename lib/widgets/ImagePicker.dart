import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key,required this.child});
final Widget child;
  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<AssetEntity> _selectedAssets = [];

  Future<bool> _requestPhotoPermission() async {
    final status = await Permission.photos.request();
    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
      return false;
    }
    return status.isGranted;
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('权限被拒绝'),
        content: const Text('请在设置中开启相册权限'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('去设置'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImages() async {
    final hasPermission = await _requestPhotoPermission();
    if (!hasPermission) return;

    final List<AssetEntity>? result = await AssetPicker.pickAssets(context);

    if (result != null) {
      setState(() => _selectedAssets = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            color: Colors.grey,
            child: widget.child,
          ),
          onTap:()
          {
            _pickImages();
          },
        ),
      ],
    );
  }
}

