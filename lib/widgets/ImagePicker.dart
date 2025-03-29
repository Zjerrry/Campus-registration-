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

    List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(maxAssets: 1), // 最多选择9张
    );

    if (result != null) {
      setState(() => _selectedAssets = result);
    }
  }

  @override
      Widget build(BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        ConstrainedBox( // 添加约束防止溢出
        constraints: const BoxConstraints(
        maxWidth: 100, // 宽度限制
          maxHeight: 100, // 高度限制
        ),
            child: GestureDetector(
            onTap: _pickImages,
                child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 1),
                borderRadius: BorderRadius.circular(20),),
                child: _buildChildWidget(), // 传入重构
                  ),
                ),
              ),
          ],
        );
      }
  Widget _buildChildWidget() {
    if (_selectedAssets.isEmpty) {
      return widget.child; // 空状态处理
    }

    return ClipRRect( // 添加圆角裁剪
      borderRadius: BorderRadius.circular(20),
      child: Image(
        image: AssetEntityImageProvider(
          _selectedAssets[0],
          isOriginal: false,
        ),
        fit: BoxFit.cover,
        width: 100,  // 显式指定尺寸
        height: 100,
      ),
    );
  }

}

