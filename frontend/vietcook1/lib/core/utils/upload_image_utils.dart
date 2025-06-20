import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UpLoadImageUtil {
  static Future<bool> _requestPhotoPermission(
    BuildContext context,
  ) async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final androidSdkVersion = androidInfo.version.sdkInt;

      if (androidSdkVersion >= 33) {
        // Android 13 trở lên
        status = await Permission.photos.request();
      } else {
        // Android dưới 13
        status = await Permission.storage.request();
      }
    } else if (Platform.isIOS) {
      status = await Permission.storage.request();
    } else {
      // Các nền tảng khác, tùy chọn
      status = await Permission.photos.request();
    }
    print("CHECK $status");
    if (status.isGranted) {
      return true;
    } else {
      _showPermissionDialog(context);

      return false;
    }
  }

  static void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cần quyền truy cập ảnh'),
        content: const Text(
          'Bạn cần cấp quyền truy cập ảnh để chọn ảnh từ thư viện. Vui lòng mở phần cài đặt và cấp quyền.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings(); // Mở phần cài đặt app
              Navigator.of(ctx).pop();
            },
            child: const Text('Cài đặt'),
          ),
        ],
      ),
    );
  }

  static Future<List<XFile>> pickImages({
    required BuildContext context,
    bool allowMultiple = true,
  }) async {
    final hasPermission = await _requestPhotoPermission(context);
    if (!hasPermission) return [];

    final picker = ImagePicker();
    if (allowMultiple) {
      return await picker.pickMultiImage();
    } else {
      final file = await picker.pickImage(source: ImageSource.gallery);
      return file != null ? [file] : [];
    }
  }

  static Future<List<String>> uploadImagesToCloudinary({
    required List<XFile> pickedFiles,
    required String fileName,
    required String uploadPreset,
  }) async {
    if (pickedFiles.isEmpty) return [];

    List<String> uploadedUrls = [];

    for (var file in pickedFiles) {
      try {
        final imageFile = File(file.path);
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final publicId = '$fileName/$timestamp';

        final url = Uri.parse(
          'https://api.cloudinary.com/v1_1/dcx4uowma/image/upload',
        );

        final request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..fields['public_id'] = publicId
          ..files.add(
            await http.MultipartFile.fromPath('file', imageFile.path),
          );

        final response = await request.send();
        final resBody = await http.Response.fromStream(response);

        if (response.statusCode == 200) {
          final data = json.decode(resBody.body);
          uploadedUrls.add(data['secure_url']);
        } else {
          throw Exception('Upload thất bại cho ${file.name}: ${resBody.body}');
        }
      } catch (e) {
        throw Exception('Lỗi khi upload ảnh ${file.name}: $e');
      }
    }

    return uploadedUrls;
  }
}
